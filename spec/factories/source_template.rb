FactoryBot.define do
  factory :source_template do
    association(:source)

    content 'Content'
  end
end
