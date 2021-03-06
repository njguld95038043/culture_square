class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @range = params[:range]

    if @range == "EndUser"
      @end_users = EndUser.search(params[:search], params[:word]).page(params[:page]).per(10)
      @nick_name = params[:word]
    elsif @range == "Review"
      @reviews = Review.search(params[:search], params[:word]).page(params[:page]).per(10)
      @review = params[:word]
    else
      @books = Book.search(params[:search], params[:word]).page(params[:page]).per(10)
      @book = params[:word]
    end
  end
end
