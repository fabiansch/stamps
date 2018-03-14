class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [:twitter]

  include DeviseTokenAuth::Concerns::User

  devise :omniauthable

  before_validation do
    self.uid = email if uid.blank?
  end


  has_many :vendors, dependent: :destroy
  has_many :stampings
  has_many :cards, -> { distinct }, through: :stampings

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end

end
