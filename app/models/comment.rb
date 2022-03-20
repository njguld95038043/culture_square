class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :review

  has_many :notifications, dependent: :destroy

end
