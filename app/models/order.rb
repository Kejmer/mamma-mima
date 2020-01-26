class Order < ApplicationRecord
  has_many :order_positions, dependent: :delete_all

  validates :receive_form, :address, :status, presence: true
  validates :status, presence: true

  belongs_to :department, required: true

  accepts_nested_attributes_for :order_positions

  validate :validate_receive
  validate :validate_status

  before_create :set_price
  before_create :consume_products

  RECEIVE_TYPE = %i(onsite deliver personal)
  STATUS_TYPE = %i(done delivery prepared cancelled ordered rejected)
  FINAL_STATUS = %i(done rejected)

  def pizza_collection
    pizzas = []
    self.order_positions.each do |pos|
      pizzas << pos.pizza_formated
    end
    pizzas
  end

  def validate_status
    self.status.in?(STATUS_TYPE)
  end

  def validate_receive
    self.receive_form.in?(RECEIVE_TYPE)
  end

  def set_price
    self.price = 0
    self.order_positions.each do |pos|
      self.price += pos.pizza_formated.price * pos.amount
    end
    return self.price > 0
  end

  def final?
    self.status.in?(FINAL_STATUS)
  end

  def restore_products
    pizza_collection do |pizza|
      pizza.reverse(self.department.id)
    end
  end

  def consume_products
    Pizza.consume(pizza_collection, self.department)
  end

end