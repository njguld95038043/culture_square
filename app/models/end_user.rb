class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum gender: { man: 1, woman: 2, other: 3}

  validates :nick_name, presence: true
  validates :gender, presence: true
  validates :occupation, presence: true
  validates :birthday, presence: true
  validates :email, presence: true

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_reviews, through: :favorites, source: :review
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :end_user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_one_attached :profile_image

  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end

  def following?(end_user)
    followings.include?(end_user)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def calc_age #生年月日から年齢を計算するメソッド
    d1 = self.birthday.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
  end

  def self.looks(search, word)
    if word == ""#空白で検索された場合はallで抽出
      @end_user = EndUser.all
    elsif search == "perfect_match"
      @end_user = EndUser.where("nick_name = ?", "#{word}")
    elsif search == "forward_match"
      @end_user = EndUser.where("nick_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @end_user = EndUser.where("nick_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @end_user = EndUser.where("nick_name LIKE?","%#{word}%")
    else
      @end_user = EndUser.all
    end
  end

  def create_notification_follow!(visitor)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",visitor.id, id, 'follow'])
    if temp.blank?
      notification = visitor.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
