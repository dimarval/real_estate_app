require 'rails_helper'

describe Agency do

  subject(:agency) { FactoryBot.build(:agency) }

  it 'is valid with a name' do
    expect(agency).to be_valid
  end

  it 'is invalid without a code' do
    agency.name = nil

    expect(agency).not_to be_valid
  end

  it 'is invalid if the name has more than 255 characters' do
    agency.name = 'a'  * 256

    expect(agency).not_to be_valid
  end

  it 'is invalid if the name was already taken' do
    FactoryBot.create(:agency, name: agency.name)

    expect(agency).not_to be_valid
  end

end
