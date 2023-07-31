class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }, index: true
      t.string :name
      t.interger :preparation_time
      t.interger :cooking_time
      t.text :description
      t.boolean :public, default: false

      t.timestamps
    end
  end
end