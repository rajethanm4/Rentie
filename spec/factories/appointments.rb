FactoryBot.define do
  factory :appointment do
    Faker::Date.between(from: '2023-04-18', to: '2023-12-30')
  end
end
