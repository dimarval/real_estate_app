require 'rails_helper'

describe PropertyType do

  subject(:property_type) { FactoryBot.build(:property_type) }

  it 'is valid with a code' do
    expect(property_type).to be_valid
  end

  it 'is invalid without a code' do
    property_type.code = nil

    expect(property_type).not_to be_valid
  end

  it 'is invalid if the code has more than 32 characters' do
    property_type.code = 'a'  * 33

    expect(property_type).not_to be_valid
  end

  it 'is invalid if the name was already taken' do
    FactoryBot.create(:property_type, code: property_type.code)

    expect(property_type).not_to be_valid
  end

end
