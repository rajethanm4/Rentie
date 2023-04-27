FactoryBot.define do
  factory :property do
    name { Faker::Lorem.paragraph }
    address { Faker::Address.full_address }
    price { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    rooms { Faker::Number.between(from: 1, to: 5) }
    
  end
end
