FactoryBot.define do
  factory :review do
    review { Faker::Lorem.characters(number:5) }
    rate { Faker::Lorem.characters(number:20) }
  end
end