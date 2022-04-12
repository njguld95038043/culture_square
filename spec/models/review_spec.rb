# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      review = FactoryBot.build(:review)
      genre = Genre.create!(name: 'test')
      end_user = EndUser.create!(nick_name: 'test', email: 'test@test', password: 'testtest', gender: 1, occupation: 'test', birthday: '1990-1-1')
      book = Book.create!(title: 'test', author: 'test', isbn: 'test', sales_date: '1990-1-1', item_price: '2000', item_caption: 'test', publisher_name: 'test', small_image_url: 'test', medium_image_url: 'test', large_image_url:'test', item_url:'test')
      review.update!(genre_id: genre.id, end_user_id: end_user.id, book_id: book.id)
      expect(review).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "reviewが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      review = Review.new(review: '', rate:3.5, genre_id:1)
      expect(review).to be_invalid
      expect(review.errors[:review]).to include("は1文字以上で入力してください")
    end
    it "rateが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      review = Review.new(review: 'hoge', rate:'', genre_id:1)
      expect(review).to be_invalid
      expect(review.errors[:rate]).to include("を入力してください")
    end
    it "rateが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      review = Review.new(review: 'hoge', rate:3.5, genre_id:'')
      expect(review).to be_invalid
      expect(review.errors[:genre]).to include("を入力してください")
    end
  end
end