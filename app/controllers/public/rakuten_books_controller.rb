class Public::RakutenBooksController < ApplicationController
  def search
    if params[:keyword].present?
      @rakuten_books = RakutenWebService::Books::Book.search(title: params[:keyword])#keywordをもとに楽天ブックスの書籍から探し出し、その情報を@rakuten_booksへ格納する
      # render json: {status: 'success', data:@rakuten_books}
      @book = Book.new
    else
      flash.now[:alert] = '本のキーワードを入力してください。'
      @genres = Genre.all
      @random_reviews = Review.includes(:favorited_end_users).limit(12).sort {|a,b| b.favorited_end_users.size <=> a.favorited_end_users.size}#いいね数順にランキング
      render 'public/homes/top'
    end
  end

end