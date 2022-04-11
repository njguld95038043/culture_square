# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, "モデルに関するテスト", type: :model do
  # describe '実際に保存してみる' do
  #   it "有効な投稿内容の場合は保存されるか" do
      review = FactoryBot.build(:review)
      genre = Genre.create!(name: 'test')
  #     review.update!(genre_id: genre.id)
  #     expect(review).to be_valid
  #   end
  # end
  context "空白のバリデーションチェック" do
    # it "reviewが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
    #   genre = Genre.create!(name: 'test')
    #   review = Review.new(review: '', rate:'3.5', genre: genre, end_user: 1, book: 1)
    #   expect(review).to be_invalid
    #   expect(review.errors[:review]).to include("can't be blank")
    # end
    it "rateが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      review = Review.new(review: 'hoge', rate:'', genre:'1', end_user:'1', book:'1')
      expect(review).to be_invalid
      expect(review.errors[:review]).to include("can't be blank")
    end
  end
end