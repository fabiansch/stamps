class Stamp < ApplicationRecord
  belongs_to :stamping
  belongs_to :card
  belongs_to :user
end
