class Review < ApplicationRecord

  belongs_to :end_user
  belongs_to :genre
  belongs_to :book

end
