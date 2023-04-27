FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    commentable { [create(:account), create(:property)].sample }
  end
end
