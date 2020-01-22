class Product < ApplicationRecord
  has_many :availabilities, dependent: :destroy

  validates :name, presence: true

  after_create :create_new_associations

  def create_new_associations
    depts = Department.all
    depts.each do |d|
      Availability.create(department_id: d.id, product_id: self.id)
    end
  end
end
