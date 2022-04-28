class Review < ApplicationRecord
  belongs_to :end_user
  belongs_to :genre
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_end_users, through: :favorites, source: :end_user
  has_many :notifications, dependent: :destroy

  validates :rate, presence: true
  validates :review, length: { minimum: 1, maximum: 400 }

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  scope :created_some_days_ago, ->(n) { where(created_at: n.days.ago.all_day) } #nに日数を代入するメソッド。nに任意の数字を入れて抽出する。

  is_impressionable counter_cache: true

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  def ranking
    Review.includes(:favorited_end_users).limit(12).sort { |a, b| b.favorited_end_users.size <=> a.favorited_end_users.size }
  end

  def self.looks(search, word)
    if word == "" # 空白で検索された場合はallで抽出
      @review = Review.all
    elsif search == "perfect_match"
      @review = Review.where("review LIKE?", "#{word}")
    elsif search == "forward_match"
      @review = Review.where("review LIKE?", "#{word}%")
    elsif search == "backward_match"
      @review = Review.where("review LIKE?", "%#{word}")
    elsif search == "partial_match"
      @review = Review.where("review LIKE?", "%#{word}%")
    else
      @review = Review.all
    end
  end

  def create_notification_favorite!(current_end_user)
    # すでに「いいね」されているか検索
    temp = Notification
      .where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ", current_end_user.id, end_user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        review_id: id,
        visited_id: end_user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_end_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:end_user_id).where(review_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, comment_id, temp_id['end_user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_end_user, comment_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_end_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_end_user.active_notifications.new(
      review_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
