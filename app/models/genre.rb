class Genre < ApplicationRecord

  has_many :reviews, dependent: :destroy

  def self.extruct_reviews_from_genre(genre)
    genre.reviews
  end
end
