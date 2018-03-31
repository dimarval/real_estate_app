FactoryBot.define do
  factory :picture do
    association(:property)

    sequence(:url) { |n| "https://www.example.com/image_#{n}" }
  end
end
