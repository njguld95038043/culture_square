class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @end_user = current_end_user
    # @book = Book.find_by(book_params[:id])
    @genres = Genre.all
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  # def book_params
  #   params.require(:book).permit(:book_id)
  # end

end
