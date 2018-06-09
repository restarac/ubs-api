FactoryBot.define do
  factory :ubs do
    name { Faker::Witcher.location }
    phone { Faker::PhoneNumber.phone_number }
    cnes_code { Faker::Number.number(8) }
    address
    score
    latitude
    longitude
  end

  sequence :latitude do |n|
    "-23.#{n}615".to_f
  end

  sequence :longitude do |n|
    "-51.#{n}435".to_f
  end
end
