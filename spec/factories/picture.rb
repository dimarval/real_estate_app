FactoryBot.define do
  factory :picture do
    association(:property)

    url 'https://www.example.com/image'
  end
end
