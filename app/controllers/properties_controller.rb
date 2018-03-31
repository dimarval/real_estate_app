class PropertiesController < ApplicationController

  def index
    @properties = Property.published.order(date: :desc)
  end

end
