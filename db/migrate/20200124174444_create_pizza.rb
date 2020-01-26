class CreatePizza < ActiveRecord::Migration[6.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.integer :price, scale: 2, null: false

      t.timestamps
    end

    create_table :recipes, id: false, primary_key: %i[pizza_id product_id] do |t|
      t.integer :amount, null: false
      t.references :product
      t.references :pizza
    end

  end
end
