class Api::ApplicationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session
  respond_to :json

  before_action :greetapi

  private

  def greetapi
    puts 'GREET Api::ApplicationController'
  end
end
