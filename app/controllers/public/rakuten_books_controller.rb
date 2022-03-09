class Public::RakutenBooksController < ApplicationController
  def search
    if params[:keyword]
      @rakuten_books = RakutenWebService::Books::Book.search(title: params[:keyword])#keywordをもとに楽天ブックスの書籍から探し出し、その情報を@rakuten_booksへ格納する
      # render json: {status: 'success', data:@rakuten_books}
    end
    @book = Book.new
  end

  def create
    if Book.find_by(isbn: book_params[:isbn])#同じ本を二重で登録しないようにfind_byでisbnを探し、trueとfalseで条件分岐を行う
      redirect_to new_review_path
    else
      @book = Book.new(book_params)
      @book.save
      redirect_to new_review_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :sales_date, :item_price, :item_caption, :publisher_name, :small_image_url, :medium_image_url, :large_image_url, :item_url)
  end

end
