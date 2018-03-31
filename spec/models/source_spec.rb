require 'rails_helper'

describe Source do

  subject(:source) { FactoryBot.build(:source) }

  it 'is valid with a code and name' do
    expect(source).to be_valid
  end

  it 'is invalid without a code' do
    source.code = nil

    expect(source).not_to be_valid
  end

  it 'is invalid if the code has more than 16 characters' do
    source.code = 'a'  * 17

    expect(source).not_to be_valid
  end

  it 'is invalid if the code was already taken' do
    FactoryBot.create(:source, code: source.code)

    expect(source).not_to be_valid
  end

  it 'is invalid without a name' do
    source.name = nil

    expect(source).not_to be_valid
  end

  it 'is invalid if the name has more than 64 characters' do
    source.name = 'a' * 65

    expect(source).not_to be_valid
  end

end
