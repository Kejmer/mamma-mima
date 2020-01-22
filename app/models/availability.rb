class Availability < ApplicationRecord
  self.primary_keys = :product_id, :department_id

  belongs_to :department, required: true
  belongs_to :product, required: true

  validates :ammount, presence: true
  validate :non_negative_ammount

  def non_negative_ammount
    self.ammount >= 0
  end

  def self.get_it(dept_id, product_id)
    Availability.where(department_id: dept_id, product_id: product_id).first
  end
end