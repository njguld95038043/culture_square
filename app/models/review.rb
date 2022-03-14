class Review < ApplicationRecord

  belongs_to :end_user
  belongs_to :genre
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_end_users, through: :favorites, source: :end_user

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
