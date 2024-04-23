FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john@example.com" }
    password { "securepassword" }
    password_confirmation { "securepassword" }
  end
end
