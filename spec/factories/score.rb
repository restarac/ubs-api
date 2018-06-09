FactoryBot.define do
  factory :score do
    size { Faker::Number.between(1, 3)}
    adaptation_for_seniors { Faker::Number.between(1, 3)}
    medical_equipment { Faker::Number.between(1, 3)}
    medicine { Faker::Number.between(1, 3)}
  end
end