class Department < ApplicationRecord
  has_many :availabilities, dependent: :delete_all
  has_many :orders, dependent: :delete_all

  validates :city, :street, :status, :price, presence: true

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

  def introduce
    str = self.city + ", "
    str += self.district + ", " if self.district.present?
    str += self.street
  end
end
