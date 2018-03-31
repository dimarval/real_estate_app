class PropertiesController < ApplicationController

  def index
    @properties = Property
      .published
      .order(date: :desc)
      .paginate(page: params[:page])
  end

end
