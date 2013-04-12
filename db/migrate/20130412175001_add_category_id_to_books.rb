class AddCategoryIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :category_id, :integer
    add_index :books, :category_id
  end
end
