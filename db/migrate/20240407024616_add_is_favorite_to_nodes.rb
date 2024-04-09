class AddIsFavoriteToNodes < ActiveRecord::Migration[7.1]
  def change
    add_column :nodes, :is_favorite, :boolean, default: false, null: false
  end
end
