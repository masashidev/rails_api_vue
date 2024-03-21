class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :body
      t.string :category

      t.timestamps
    end
  end
end
