class Public::RakutenBooksController < ApplicationController
  def search
    if params[:keyword]
      @rakuten_books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
    @book = Book.new
  end

  def create
    binding.pry
    @book = Book.new(book_params)
    @book.save
    redirect_to new_review_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :sales_date, :item_price, :item_caption, :publisher_name, :small_image_url, :medium_image_url, :large_image_url, :item_url)
  end

end
