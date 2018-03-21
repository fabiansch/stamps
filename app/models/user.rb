class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [:twitter]

  before_validation do
    puts "USER::before_validation uid is #{ uid.blank? ? "blank" : "not blank"}"
    puts email.inspect

    self.uid = email if uid.blank?
  end

  attr_reader :is_vendor

  include DeviseTokenAuth::Concerns::User

  devise :omniauthable


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

  def is_vendor
    return self.vendors.length > 0;
  end

  def as_json(options={})
    super(options).merge( {is_vendor: is_vendor} )
  end

end
