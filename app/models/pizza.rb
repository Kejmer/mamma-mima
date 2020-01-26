class Pizza < ApplicationRecord
  has_many :recipes, dependent: :delete_all

  validates :name, presence: true
  validates :price, presence: true

  validate :non_negative_amount

  accepts_nested_attributes_for :recipes

  def non_negative_amount
    errors.add(:price, 'Nie moze byc ujemne') unless self.price >= 0
  end

  def full_recipe
    collected_recipe = {}
    self.recipes.each do |r|
      collected_recipe[r.name] = r.amount
    end
  end

  def self.all_products(pizzas)
    result = {}
    pizzas.each do |piz|
      piz.recipes.each do |rec|
        result[rec[:product_id]] ||= 0
        result[rec[:product_id]] += rec[:amount]
      end
    end
    result
  end

  def self.consume(pizzas, dept)
    products = all_products(pizzas)
    Availability.transaction do
      products.each do |key, val|
        dept.decrease_product(key, val)
      end
    end
  end

  def reverse(dept_id)
    self.recipes.each do |r|
      Availability.get_it(dept_id, r.product.id).decrease_product(r.amount)
    end
  end

end