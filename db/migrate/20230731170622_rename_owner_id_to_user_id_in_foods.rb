class RenameOwnerIdToUserIdInFoods < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :owner_id, :user_id
    rename_column :recipes, :owner_id, :user_id
    add_index :foods, :user_id
    add_index :recipes, :user_id
  end
end
