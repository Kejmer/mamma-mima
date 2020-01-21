class Availability < ApplicationRecord
  has_one: :department, required: true
  has_one: :product, required: true

  validates :ammount, presence: true
  validate :non_negative_ammount

  def non_negative_ammount
    self.ammount >= 0
  end
end