require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:prestation) { create(:prestation) }

    before do
      allow(User).to receive(:first).and_return(user)
      allow_any_instance_of(BookingsController)
        .to receive(:find_closest_professionals)
        .and_return([1, 2, 3]) # Assuming these IDs exist for Professionals
    end

    context 'with valid parameters and professionals found' do
      it 'creates a new booking' do
        expect {
          post :create, params: { booking: { prestation_id: prestation.id, address_of_prestation: '5 rue Mouffetard, Paris', lat: 123, lng: 456 } }
        }.to change(Booking, :count).by(1)
      end

      it 'redirects to the confirmation path with professionals' do
        post :create, params: { booking: { prestation_id: prestation.id, address_of_prestation: '123 Main St', lat: 123, lng: 456 } }
        expect(response).to redirect_to(confirmation_path(nearest_professionals: [1, 2, 3]))
      end
    end

    context 'with valid parameters but no professionals found' do
      before do
        allow_any_instance_of(BookingsController)
          .to receive(:find_closest_professionals)
          .and_return([])
      end

      it 'redirects to the confirmation path without professionals' do
        post :create, params: { booking: { prestation_id: prestation.id, address_of_prestation: '123 Main St', lat: 123, lng: 456 } }
        expect(response).to redirect_to(confirmation_path(nearest_professionals: []))
      end
    end
  end
end
