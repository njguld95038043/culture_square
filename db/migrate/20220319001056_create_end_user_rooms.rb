class CreateEndUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :end_user_rooms do |t|
      t.integer :end_user_id, null: false
      t.integer :room_id, null: false

      t.timestamps
    end
  end
end
