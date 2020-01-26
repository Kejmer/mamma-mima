class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :price, scale: 2, null: false
      t.string :address
      t.string :receive_form
      t.string :status
      t.string :additional_info

      t.timestamps
    end

    create_table :order_positions, id: false, primary_key: %i[pizza_id order_id] do |t|
      t.integer :amount, null: false
      t.references :order
      t.references :pizza
    end

  end
end
