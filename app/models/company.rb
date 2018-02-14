class Company < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :vendors, dependent: :destroy
  has_many :cards
end
