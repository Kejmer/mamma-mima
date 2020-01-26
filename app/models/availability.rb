class Availability < ApplicationRecord
  self.primary_keys = :product_id, :department_id

  belongs_to :department, required: true
  belongs_to :product, required: true

  validates :amount, presence: true
  validate :non_negative_amount

  validates_uniqueness_of :department_id, :scope => [:product_id]

  def non_negative_amount
    errors.add(:amount, 'Nie moze byc ujemne') unless self.amount >= 0
  end

  def self.get_it(dept_id, product_id)
    Availability.where(department_id: dept_id, product_id: product_id).first
  end

  def decrease_product(amount)
    self.amount -= amount
    raise ActiveRecord::Rollback unless self.save
  end
end