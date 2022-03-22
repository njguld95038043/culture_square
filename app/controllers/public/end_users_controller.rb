class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_correct_end_user, only: [:edit, :update]

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
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user), notice: 'Your information have been updated!'
    else
      render :edit
    end
  end

  def unsubscribe
    @end_user = current_end_user
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted: true)#ここでis_deletedカラムの値をtrueに更新します。
    reset_session #この記述で現在のログイン状況をリセット
    flash[:notice] = "退会が完了しました。"
    redirect_to root_path #処理完了後ルートパスへ遷移。
  end

  private

  def end_user_params
    params.require(:end_user).permit(:nick_name, :birthday, :gender, :occupation, :email, :is_deleted, :profile_image)
  end

  def ensure_correct_end_user
    @end_user = EndUser.find(params[:id])
    unless @end_user == current_end_user
      redirect_to end_user_path(current_end_user)
    end
  end

end
