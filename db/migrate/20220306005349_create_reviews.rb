class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :end_user_id, null: false
      t.integer :book_id, null: false
      t.integer :genre_id, null: false
      t.text :review, null: false

      t.timestamps
    end
  end
end
