FactoryBot.define do
  factory :goal do
    user_id { 2 }
    title {Faker::HarryPotter.spell}
    body {Faker::MichaelScott.quote}
  end
end
