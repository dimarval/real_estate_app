FactoryBot.define do
  factory :property do
    association(:type, factory: :property_type)
    association(:operation_type)

    title       'My property'
    description 'My property description'
    city        'Cuauhtémoc'
    city_area   'Condesa'
    region      'Ciudad de México'
    date        { Date.today - rand(0..30).days }
  end
end
