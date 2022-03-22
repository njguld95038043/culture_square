class Chat < ApplicationRecord

  belongs_to :end_user
  belongs_to :room

  validates :message, length: { minimum: 1, maximum: 140 }

end
