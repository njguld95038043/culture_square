class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @range = params[:range]

    if @range == "EndUser"
      @end_users = EndUser.looks(params[:search], params[:word])
    elsif @range == "Review"
      @reviews = Review.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
