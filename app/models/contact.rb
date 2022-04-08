class Contact < ApplicationRecord

  validates :nick_name, presence: true
  validates :email, presence: true
  validates :content, presence: true

end
