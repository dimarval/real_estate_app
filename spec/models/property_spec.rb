require 'rails_helper'

describe Property do

  subject(:property) { FactoryBot.build(:property) }

  it 'is valid with title, content, type, operation_type city, city_area, ' \
     'region and date' do
    expect(property).to be_valid
  end

  it 'is invalid without a title' do
    property.title = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if the title has more than 255 characters' do
    property.title = 'a' * 256

    expect(property).not_to be_valid
  end

  it 'is invalid without a description' do
    property.description = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if the description has more than 2048 characters' do
    property.description = 'a' * 2049

    expect(property).not_to be_valid
  end

  it 'is invalid without a type_id' do
    property.type_id = nil

    expect(property).not_to be_valid
  end

  it 'is invalid without a operation_type_id' do
    property.operation_type_id = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if thas a floor_area and floor_area_unit but the ' \
     'floor_area is not a number' do
    property.floor_area      = 'five'
    property.floor_area_unit = FactoryBot.create(:measurement_unit)

    expect(property).not_to be_valid
  end

  it 'is invalid if has a floor_area and not floor_area_unit' do
    property.floor_area      = 500
    property.floor_area_unit = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if has a floor_area and floor_area_unit' do
    property.floor_area      = 500
    property.floor_area_unit = FactoryBot.create(:measurement_unit)

    expect(property).to be_valid
  end

  it 'is invalid if thas a plot_area and plot_area_unit but the ' \
     'plot_area is not a number' do
    property.plot_area      = 'five'
    property.plot_area_unit = FactoryBot.create(:measurement_unit)

    expect(property).not_to be_valid
  end

  it 'is invalid if has a plot_area and not plot_area_unit' do
    property.plot_area      = 500
    property.plot_area_unit = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if has a plot_area and plot_area_unit' do
    property.plot_area      = 500
    property.plot_area_unit = FactoryBot.create(:measurement_unit)

    expect(property).to be_valid
  end

  it 'is invalida if rooms is not a number' do
    property.rooms = 'five'

    expect(property).not_to be_valid
  end

  it 'is invalida if bathrooms is not a number' do
    property.bathrooms = 'five'

    expect(property).not_to be_valid
  end

  it 'is invalida if parking is not a number' do
    property.parking = 'five'

    expect(property).not_to be_valid
  end

  it 'is invalid without a city' do
    property.city = nil

    expect(property).not_to be_valid
  end

  it 'is invalida if the city has more than 255 characters' do
    property.city = 'a' * 256

    expect(property).not_to be_valid
  end

  it 'is invalid without a city_area' do
    property.city_area = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if the city_area has more than 255 caharacters' do
    property.city_area = 'a' * 256

    expect(property).not_to be_valid
  end

  it 'is invalid wihout a region' do
    property.region = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if the region has more then 255 characters' do
    property.region = 'a' * 256

    expect(property).not_to be_valid
  end

  it 'is invalid if the price and price currency but the price ' \
     'is not a number' do
    property.price          = 'five'
    property.price_currency = FactoryBot.create(:currency)

    expect(property).not_to be_valid
  end

  it 'is invalid if has a price and not a price_currency' do
    property.price          = 500
    property.price_currency = nil

    expect(property).not_to be_valid
  end

  it 'is valid with a price and price_currency' do
    property.price          = 500
    property.price_currency = FactoryBot.create(:currency)

    expect(property).to be_valid
  end

  it 'is invalid wihtout a date' do
    property.date = nil

    expect(property).not_to be_valid
  end

  it 'is valid if the value of published is true' do
    property.published = true

    expect(property).to be_valid
  end

  it 'is valid if the value of published is false' do
    property.published = false

    expect(property).to be_valid
  end

  it 'is invalid if the value of published is not true or false' do
    property.published = nil

    expect(property).not_to be_valid
  end

  it 'is invalid if the extarnal_id has more than 16 characters' do
    property.external_id = 'a' * 17

    expect(property).not_to be_valid
  end

  it 'is invalid if the extenal_id in combination with external_agency_id ' \
     'was already taken' do
    property.external_id     = 'abcde123'
    property.external_agency = FactoryBot.create(:agency)

    FactoryBot.create(
      :property,
      external_id:     property.external_id,
      external_agency: property.external_agency,
    )

    expect(property).not_to be_valid
  end

  it 'is invalid if the external_url has more than 255 characters' do
    property.external_url = 'a' * 256

    expect(property).not_to be_valid
  end

  describe '.published' do

    it 'retrives the properties published' do
      property = FactoryBot.create(:property, published: true)

      FactoryBot.create(:property, published: false)

      expect(Property.published).to eq [property]
    end

  end

  describe '#pictures' do

    it 'retrives the pictures ordered by id in ascending order' do
      property.save

      picture_1 = FactoryBot.create(:picture, property: property)
      picture_2 = FactoryBot.create(:picture, property: property)

      expect(property.pictures).to eq [picture_1, picture_2]
    end

  end

end
