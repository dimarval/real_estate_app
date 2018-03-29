require 'rails_helper'

describe MeasurementUnit do

  subject(:measurement_unit) { FactoryBot.build(:measurement_unit) }

  it 'is valid with a code' do
    expect(measurement_unit).to be_valid
  end

  it 'is invalid without a code' do
    measurement_unit.code = nil

    expect(measurement_unit).not_to be_valid
  end

  it 'is invalid if the code has more than 32 characters' do
    measurement_unit.code = 'a'  * 33

    expect(measurement_unit).not_to be_valid
  end

  it 'is invalid if the name was already taken' do
    FactoryBot.create(:measurement_unit, code: measurement_unit.code)

    expect(measurement_unit).not_to be_valid
  end

end
