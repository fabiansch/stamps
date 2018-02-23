class Stamping < ApplicationRecord
  belongs_to :card
  belongs_to :user
  belongs_to :vendor
  belongs_to :address
  has_many :stamps
end
