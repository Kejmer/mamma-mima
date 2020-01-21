class Department < ApplicationRecord
  has_many :availabilities, dependent: :destroy
  has_many :products, through: :availabilities

  validates :city, :street, presence: true

  after_create :create_empty_products

  def create_empty_products
    products = Product.all
    products.each do |p|
      Availability.create!(ammount: 0, product: p, department: self)
    end
  end
end
