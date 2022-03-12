class Public::HomesController < ApplicationController
  def top
    @end_user = current_end_user
    @genres = Genre.all
    @random_reviews = Review.all.shuffle
  end

  def about
  end
end
