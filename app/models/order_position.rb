class OrderPosition < ApplicationRecord
  self.primary_keys = :order_id, :pizza_id

  belongs_to :order, required: true
  belongs_to :pizza, required: true

  validates :amount, presence: true
  validate :non_negative_amount

  validates_uniqueness_of :order_id, :scope => [:pizza_id]

  def non_negative_amount
    errors.add(:amount, 'Nie moze byc ujemne') unless self.amount >= 0
  end

  def pizza_formated
    self.pizza # później można odpowiednio mnożyć razy rozmiar
  end

end