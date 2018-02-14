class Card < ApplicationRecord
  belongs_to :company
  has_many :stamps
  has_many :transactions
end
