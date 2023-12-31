class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :name
      t.string :measurement_unit
      t.decimal :price, precision: 10, scale: 2
      t.decimal :quantity, precision: 10, scale: 2

      t.timestamps
    end
  end
end
