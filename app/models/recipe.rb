class Recipe < ApplicationRecord
  self.primary_keys = :product_id, :pizza_id

  belongs_to :product, required: true
  belongs_to :pizza, required: true

  validates :amount, presence: true
  validate :non_negative_amount

  def non_negative_amount
    errors.add(:amount, 'Nie moze byc ujemne') unless self.amount >= 0
  end

end