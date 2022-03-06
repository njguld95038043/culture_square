class Public::HomesController < ApplicationController
  def top
    @end_user = current_end_user
    @genres = Genre.all
  end

  def about
  end
end
