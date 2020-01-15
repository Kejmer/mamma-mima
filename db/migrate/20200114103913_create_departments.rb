class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :city, null: false
      t.string :district, null: true
      t.string :street, null: false
      t.decimal :profits, null: false, default: 0, precision: 2
      t.decimal :expenses, null: false, default: 0, precision: 2

      t.timestamps
    end
  end
end
