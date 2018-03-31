require 'rails_helper'

describe Picture do

  subject(:picture) { FactoryBot.build(:picture) }

  it 'is valid with an property_id and url' do
    expect(picture).to be_valid
  end

  it 'is invalid without an property_id' do
    picture.property_id = nil

    expect(picture).not_to be_valid
  end

  it 'is invalid without an url' do
    picture.url = nil

    expect(picture).not_to be_valid
  end

  it 'is invalid if the url has more than 255 characters' do
    picture.url = 'a'  * 256

    expect(picture).not_to be_valid
  end

  it 'is invalid if the property_id in combination with url has already taken' do
    FactoryBot.create(:picture, property: picture.property, url: picture.url)

    expect(picture).not_to be_valid
  end

end
