class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.text :description
      t.date :publish_date

      t.timestamps
    end
  end
end
