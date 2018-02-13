class CallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect @user, :event => :authentication
    else
      # http://stackoverflow.com/questions/7117200/devise-for-twitter-cookie-overflow-error
      session["devise.twitter_data"] = request.env["omniauth.auth"].except('extra')
      redirect_to new_user_registration_url
    end
  end
end
