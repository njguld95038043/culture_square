class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def self.search(search, word)
    return all if word.blank?

    if search == "perfect_match"
      where("title = ?", "#{word}")
    elsif search == "forward_match"
      where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      where("title LIKE?", "%#{word}%")
    else
      all
    end
  end
end
