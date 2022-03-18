class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])

    @reviews = @end_user.reviews.page(params[:page]).reverse_order
    @today_review =  @reviews.created_today
    @yesterday_review = @reviews.created_yesterday
    @this_week_review = @reviews.created_this_week
    @last_week_review = @reviews.created_last_week
    @review = Review.new
  end

  def index
    @end_users = EndUser.all
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to end_user_path(@end_user)
  end

  def unsubscribe
    @end_user = EndUser.find(params[:id])
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:nick_name, :birthday, :gender, :occupation, :email, :is_deleted, :profile_image)
  end
end
