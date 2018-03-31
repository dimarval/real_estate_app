require 'rails_helper'

describe PropertiesController do

  describe 'GET #index' do

    before(:each) do
      @property_1 = FactoryBot.create(
        :property,
        date:      Date.today - 2.days,
        published: true,
      )

      @property_2 = FactoryBot.create(
        :property,
        date:      Date.today,
        published: true,
      )

      FactoryBot.create(:property, published: false)

      get :index
    end

    it 'populates @properties variable with published properties ' \
       'ordered by date in descending order' do
      expect(assigns(:properties)).to eq [@property_2, @property_1]
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'renders index template' do
      expect(response).to render_template :index
    end

  end

end
