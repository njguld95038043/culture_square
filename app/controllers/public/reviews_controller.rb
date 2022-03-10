class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @end_user = current_end_user
    @genres = Genre.all
  end

  def create
    @review = current_end_user.reviews.new(review_params)
    @review.book_id = book.id
    @review.save
    redirect_to review_path(@review)
  end

  def index
  end

  def show
    @end_user = current_end_user
    @review = Review.find(params[:id])
  end

  def edit
  end

  private

  def review_params
    params.require(:review).permit(:genre, :review)
  end

end
