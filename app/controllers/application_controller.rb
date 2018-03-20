class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: -> { request.format.json? }
  before_action :greet



protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:format, session: [:email, :password]])
  end


private

  def greet
    puts "GREET ApplicationController with format: #{ request.format.json? ? "JSON" : "NOJSON"}"
  end
end
