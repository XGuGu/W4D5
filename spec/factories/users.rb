FactoryBot.define do
  factory :user do
    username {Faker::Pokemon.name}
    password { "pokemon" }
  end
end
