class Public::RakutenBooksController < ApplicationController
  def search
    if params[:keyword]
      @rakuten_books = RakutenWebService::Books::Book.search(title: params[:keyword])#keywordをもとに楽天ブックスの書籍から探し出し、その情報を@rakuten_booksへ格納する
      # render json: {status: 'success', data:@rakuten_books}
      @book = Book.new
    else
      flash.now[:alert] = '本のキーワードを入力してください。'
      render '/'
    end
  end

end