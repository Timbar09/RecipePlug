class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }, index: true
      t.string :name
      t.string :measurement_unit
      t.decimal :price, precision: 10, scale: 2
      t.decimal :quantity, precision: 10, scale: 2

      t.timestamps
    end
  end
end
