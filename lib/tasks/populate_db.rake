desc "populate wecasatest_development from data.json"
task populate_db: :environment do

  # I created differents methods to create each type of resources. Professional is the central table here.
  # So i decided to create each resources belonging to professionals in #create_professionals.
  # I then create bookings and associate user and prestations to it.

  def create_professionals(professionals_data)
    professionals_data.each do |pro_data|
      next unless pro_data["name"] && pro_data["address"]

      professional = Professional.find_or_create_by(name: pro_data["name"], address: pro_data["address"]) do |pro|
        pro.lattitude = pro_data["lat"]
        pro.longitude = pro_data["lng"]
        pro.max_kil = pro_data["max_kilometers"]

        puts "Created/Found professional: #{pro.name}"
      end

      # Create opening hours, appoitments and prestations and associate to each professionnal
      create_opening_hours(professional, pro_data["opening_hours"]) if pro_data["opening_hours"]
      create_appoitments(professional, pro_data["appointments"]) if pro_data["appointments"]
      associate_prestations(professional, pro_data["prestations"]) if pro_data["prestations"]
    end
  end

  def create_opening_hours(professional, opening_hours_data)
    opening_hours_data.each do |hours_data|
      next unless hours_data["day"]

      OpeningHour.find_or_create_by(professional_id: professional.id, day: hours_data["day"]) do |hours|
        hours.open_at = hours_data["starts_at"]
        hours.close_at = hours_data["ends_at"]
      end

      puts "Set opening hours for #{professional.name} on #{hours_data["day"]}"
    end
  end

  def create_appoitments(professional, appointments_data)
    appointments_data.each do |ap_data|
      next unless ap_data["day"]

      Appointment.find_or_create_by(professional_id: professional.id, starts_at: ap_data["starts_at"]) do |appointment|
        appointment.ends_at = ap_data["ends_at"]
      end

      puts "Set appointment for #{professional.name} on #{ap_data["starts_at"]}"
    end
  end

  def associate_prestations(professional, prestations_data)
    prestations_data.each do |presta_data|
      prestation = Prestation.find_or_create_by(reference: presta_data) do |p|
        p.duration = presta_data["duration"]
      end
      professional.prestations << prestation unless professional.prestations.include?(prestation)

      puts "Set prestation for #{prestation.reference}"
    end
  end

  def create_user(booking_data)
    user = User.create!(
      name: booking_data["name"],
      email: booking_data["email"],
      password: "azerty",
      password_confirmation: "azerty"
    )
  end

  def create_bookings(bookings_data)
    bookings_data.each do |booking_data|
      next unless booking_data["email"] && booking_data["starts_at"]

      user = create_user(booking_data)
      puts "Created User #{user.name}" if user

      booking = Booking.find_or_create_by(starts_at: booking_data["starts_at"], address_of_prestation: booking_data["address"]) do |bk|
        bk.lat = booking_data["lat"]
        bk.lng = booking_data["lng"]

        bk.prestation = Prestation.find_by(reference: booking_data["prestations"])
        bk.user = user

        puts "Created/Found booking: #{bk.email} + #{bk.starts_at}"
      end
    end
  end

  # ----------------

  file_path = Rails.root.join('lib/tasks/data/data.json')
  data = JSON.parse(File.read(file_path))

  begin
    data = JSON.parse(File.read(file_path))
    create_professionals(data["pros"]) if data["pros"]
    create_bookings(data["bookings"]) if data["bookings"]
  rescue Errno::ENOENT
    puts "File not found: #{file_path}"
    exit
  rescue JSON::ParserError
    puts "Invalid JSON in file."
    exit
  end

end
