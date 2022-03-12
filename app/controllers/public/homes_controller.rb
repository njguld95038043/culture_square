class Public::HomesController < ApplicationController
  def top
    @end_user = current_end_user
    @genres = Genre.all
    @random_reviews = Review.all.shuffle[0..11]
  end

  def about
  end
end
