class Room < ApplicationRecord

  has_many :chats
  has_many :end_user_rooms

end
