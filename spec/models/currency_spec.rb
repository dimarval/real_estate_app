require 'rails_helper'

describe Currency do

  subject(:currency) { FactoryBot.build(:currency) }

  it 'is valid with a code' do
    expect(currency).to be_valid
  end

  it 'is invalid without a code' do
    currency.code = nil

    expect(currency).not_to be_valid
  end

  it 'is invalid if the code has more than 32 characters' do
    currency.code = 'a'  * 33

    expect(currency).not_to be_valid
  end

  it 'is invalid if the name was already taken' do
    FactoryBot.create(:currency, code: currency.code)

    expect(currency).not_to be_valid
  end

end
