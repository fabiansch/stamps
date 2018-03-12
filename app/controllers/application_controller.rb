class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :authenticate_user!, unless: -> { request.format.json? }

  before_action :greet

  private

  def greet
    puts 'GREET ApplicationController'
  end
end
