class Public::HomesController < ApplicationController
  def top
    @end_user = current_end_user
  end

  def about
  end
end
