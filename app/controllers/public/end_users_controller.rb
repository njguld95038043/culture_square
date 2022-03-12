class Public::EndUsersController < ApplicationController
  def show
    @end_user = current_end_user
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to end_users_my_page_path
  end

  def unsubscribe
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
