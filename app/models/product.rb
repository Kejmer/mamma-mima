class Product < ApplicationRecord
  has_many :availabilities

  validates :name, presence: true

  after_create :create_new_associations

  def create_new_associations
    depts = Department.all
    depts.each do |d|
      Availability.create!(ammount: 0, product: self, department: d)
    end
  end
end
