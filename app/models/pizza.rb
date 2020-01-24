class Pizza < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true

  validate :non_negative_amount

  def non_negative_amount
    errors.add(:price, 'Nie moze byc ujemne') unless self.price >= 0
  end

  def full_recipe
    collected_recipe = {}
    self.recipes.each do |r|
      collected_recipe[r.name] = r.amount
    end
  end

  def use_products
    self.full_recipe.each do |pr, am|

    end
  end
end