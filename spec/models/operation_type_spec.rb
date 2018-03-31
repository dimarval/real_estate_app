require 'rails_helper'

describe OperationType do

  subject(:operation_type) { FactoryBot.build(:operation_type) }

  it 'is valid with a code' do
    expect(operation_type).to be_valid
  end

  it 'is invalid without a code' do
    operation_type.code = nil

    expect(operation_type).not_to be_valid
  end

  it 'is invalid if the code has more than 32 characters' do
    operation_type.code = 'a'  * 33

    expect(operation_type).not_to be_valid
  end

  it 'is invalid if the name was already taken' do
    FactoryBot.create(:operation_type, code: operation_type.code)

    expect(operation_type).not_to be_valid
  end

end
