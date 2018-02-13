class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:twitter]

  def self.find_for_twitter_oauth(access_token, signed_in_resource = nil)
    data = access_token.extra.raw_info
    if user = User.where(:username => data.screen_name).first
        user
    else
        User.create!(:username => data.screen_name, :password => Devise.friendly_token)
    end
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

end
