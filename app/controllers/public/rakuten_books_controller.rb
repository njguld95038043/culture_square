class Public::RakutenBooksController < ApplicationController
  def search
    if params[:keyword]
      @rakuten_books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

end
