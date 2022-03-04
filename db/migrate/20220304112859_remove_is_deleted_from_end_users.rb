class RemoveIsDeletedFromEndUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :end_users, :is_deleted, :boolean
  end
end
