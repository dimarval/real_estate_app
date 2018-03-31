FactoryBot.define do
  factory :property_type do
    sequence(:code) { |n| "property_type_#{n}" }
  end
end
