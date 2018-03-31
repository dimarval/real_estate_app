FactoryBot.define do
  factory :measurement_unit do
    sequence(:code) { |n| "unit_#{n}" }
  end
end
