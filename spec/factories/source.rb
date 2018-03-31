FactoryBot.define do
  factory :source do
    sequence(:code) { |n| "source_#{n}" }

    name 'My source'
  end
end
