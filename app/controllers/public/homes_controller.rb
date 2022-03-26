class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @random_reviews = Review
      .includes(:favorited_end_users)
      .limit(12)
      .sort { |a, b| b.favorited_end_users.size <=> a.favorited_end_users.size } # いいね数順にランキング
  end

  def about
  end
end
