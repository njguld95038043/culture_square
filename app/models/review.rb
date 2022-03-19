class Review < ApplicationRecord

  belongs_to :end_user
  belongs_to :genre
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_end_users, through: :favorites, source: :end_user


  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) }
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) }

  is_impressionable counter_cache: true

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  def ranking
    Review.includes(:favorited_end_users).limit(12).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size}
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("review LIKE?","#{word}")
    elsif search == "forward_match"
      @review = Review.where("review LIKE?","#{word}%")
    elsif search == "backward_match"
      @review = Review.where("review LIKE?","%#{word}")
    elsif search == "partial_match"
      @review = Review.where("review LIKE?","%#{word}%")
    else
      @review = Review.all
    end
  end

end
