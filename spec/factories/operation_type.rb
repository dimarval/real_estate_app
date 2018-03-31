FactoryBot.define do
  factory :operation_type do
    sequence(:code) { |n| "operation_type_#{n}" }
  end
end
