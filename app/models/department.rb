class Department < ApplicationRecord
  has_many :availabilities, dependent: :destroy

  validates :city, :street, presence: true

  after_create :create_new_associations

  def create_new_associations
    products = Product.all
    products.each do |p|
      Availability.create(department_id: self.id, product_id: p.id)
    end
  end

  def decrease_product(product_id, amount)
    self.availabilities.where(product_id: product_id).first.decrease_product(amount)
  end
end
