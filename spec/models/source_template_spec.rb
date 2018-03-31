require 'rails_helper'

describe SourceTemplate do

  subject(:source_template) { FactoryBot.build(:source_template) }

  it 'is valid with a source_id and content' do
    expect(source_template).to be_valid
  end

  it 'is invalid without a source_id' do
    source_template.source_id = nil

    expect(source_template).not_to be_valid
  end

  it 'is invalid without a content' do
    source_template.content = nil

    expect(source_template).not_to be_valid
  end

end
