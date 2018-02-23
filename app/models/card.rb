class Card < ApplicationRecord
  belongs_to :company
  has_many :stampings
  has_many :stamps
end
