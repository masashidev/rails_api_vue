class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :nodes do |t|
      t.string :name

      t.timestamps
    end
    add_index :nodes, :name, unique: true
  end
end
