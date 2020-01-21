class Department < ApplicationRecord
  has_many :availabilities

  validates :city, :street, presence: true
end
