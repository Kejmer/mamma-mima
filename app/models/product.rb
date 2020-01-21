class Product < ApplicationRecord
  has_many :availabilities

  validates :name, presence: true
end
