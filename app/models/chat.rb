class Chat < ApplicationRecord

  belongs_to :end_user
  belongs_to :room

end
