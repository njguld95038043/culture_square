class Public::ReviewsController < ApplicationController

  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

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
    if @review.save
      redirect_to review_path(@review), notice: 'Your review has been posted!'
    else
      redirect_to request.referer, alert: 'エラーが発生しました。項目をすべて入力してください。'
    end
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    impressionist(@review, nil, unique: [:ip_address])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review), notice: 'Your review has been updated!'
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path
  end

  def sort_new
    @reviews = Review.where(genre_id: params[:genre_id]).order(updated_at: :desc)
    @genre_id = params[:genre_id]
  end

  def sort_rate
    @reviews = Review.where(genre_id: params[:genre_id]).order(rate: :desc)
    @genre_id = params[:genre_id]
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :sales_date, :item_price, :item_caption, :publisher_name, :small_image_url, :medium_image_url, :large_image_url, :item_url)
  end

  def review_params
    params.require(:review).permit(:review, :genre_id, :rate)
  end

  def ensure_correct_end_user
    @review = Review.find(params[:id])
    @end_user = @review.end_user
    unless @end_user == current_end_user
      redirect_to root_path
    end
  end

end