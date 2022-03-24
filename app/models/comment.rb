class Comment < ApplicationRecord

  belongs_to :end_user
  belongs_to :review

  has_many :notifications, dependent: :destroy

  validates :comment, length: { minimum: 1, maximum: 140 }

end
