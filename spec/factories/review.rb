FactoryBot.define do
  factory :end_user do
    nick_name { "test" }
    email { "test@example.com" }
    gender { 1 }
    occupation { "test" }
    birthday { "1990-1-1" }
    password { "testtest" }
    password_confirmation { "testtest" }
  end
  factory :review do
    review { Faker::Lorem.characters(number:5) }
    rate { Faker::Lorem.characters(3.5) }
  end
end