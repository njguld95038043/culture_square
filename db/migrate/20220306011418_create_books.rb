class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false
      t.string :sales_date, null: false
      t.integer :item_price, null: false
      t.text :item_caption, null: false
      t.string :publisher_name, null: false
      t.text :small_image_url, null: false
      t.text :medium_image_url, null: false
      t.text :large_image_url, null: false
      t.text :item_url, null: false

      t.timestamps
    end
  end
end
