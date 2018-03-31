class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :version

  private

  def version
    RealEstateApp::Application::VERSION
  end

end
