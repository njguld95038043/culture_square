class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to request.referer, notice: 'ジャンルの新規登録に成功しました。'
    else
      @genres = Genre.all
      render :index
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to request.referer
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
