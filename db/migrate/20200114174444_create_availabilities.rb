class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities, id: false, primary_key: %i[department_id product_id] do |t|
      t.integer :ammount, null: false, default: 0
      t.references :department
      t.references :product

      t.timestamps
    end
  end
end
