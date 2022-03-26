class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def self.looks(search, word)
    if word == "" # 空白で検索された場合はallで抽出
      @book = Book.all
    elsif search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
end
