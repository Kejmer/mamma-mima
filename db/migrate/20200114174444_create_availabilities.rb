class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availability, id: false do |t|
      t.integer :ammount, null: false, default: 0

      t.timestamps
    end
    add_reference :availability, :department, index: true
    add_reference :availability, :product, index: true
    add_foreign_key :availability, :departments
    add_foreign_key :availability, :products

    # execute "ALTER TABLE availability ADD CONSTRAINT PK_Availability PRIMARY KEY (product_id, department_id);
  end
end
