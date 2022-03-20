class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @range = params[:range]

    if @range == "EndUser"
      @end_users = EndUser.looks(params[:search], params[:word])
      @nick_name = params[:word]
    elsif @range == "Review"
      @reviews = Review.looks(params[:search], params[:word])
      @review = params[:word]
    else
      @books = Book.looks(params[:search], params[:word])
      @book = params[:word]
    end
  end
end
