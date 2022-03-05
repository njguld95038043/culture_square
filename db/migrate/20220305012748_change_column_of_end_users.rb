class ChangeColumnOfEndUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :end_users, :nick_name, false
    change_column_null :end_users, :birthday, false
    change_column_null :end_users, :gender, false
    change_column_null :end_users, :occupation, false
    change_column_null :end_users, :is_deleted, false
  end
end
