FactoryBot.define do
  factory :currency do
    sequence(:code) { |n| "currency_#{n}" }
  end
end
