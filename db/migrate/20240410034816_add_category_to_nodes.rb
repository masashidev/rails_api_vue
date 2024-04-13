class AddCategoryToNodes < ActiveRecord::Migration[7.1]
  def change
    add_column :nodes, :category, :string

    add_index :nodes, :category
  end
end
