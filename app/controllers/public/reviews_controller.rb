class Public::ReviewsController < ApplicationController
  def new
    @end_user = current_end_user
    @book = Book.find(params[:id])
  end

  def index
  end

  def show
  end

  def edit
  end
end
