class RemoveCategoryFromNodesAndAddCategoryId < ActiveRecord::Migration[7.1]
  def change
    remove_column :nodes, :category, :string
    add_reference :nodes, :category, foreign_key: true
  end
end
