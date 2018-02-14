class Transaction < ApplicationRecord
  belongs_to :card
  belongs_to :user
  has_many :stamps, through: :cards
end
