FactoryBot.define do
  factory :account do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    mobileno {Faker::PhoneNumber.cell_phone_with_country_code }
    email { Faker::Internet.email }
    password {'Raj@123'}
  end
end
