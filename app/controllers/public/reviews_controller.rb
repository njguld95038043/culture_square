class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
    @genres = Genre.all
    @book = Book.new(book_params)
  end

  def create
    unless @book = Book.find_by(isbn: book_params[:isbn])#同じ本を二重で登録しないようにfind_byでisbnを探し、trueとfalseで条件分岐を行う
      @book = Book.new(book_params)
      @book.save!
    end

    @review = current_end_user.reviews.new(review_params)
    @review.book_id = @book.id
    @review.save
    redirect_to review_path(@review)
  end


  def index
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :sales_date, :item_price, :item_caption, :publisher_name, :small_image_url, :medium_image_url, :large_image_url, :item_url)
  end

  def review_params
    params.require(:review).permit(:review, :genre_id)
  end

end