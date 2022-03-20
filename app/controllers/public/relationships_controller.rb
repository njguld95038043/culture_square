class Public::RelationshipsController < ApplicationController

  def create
    current_end_user.follow(params[:end_user_id])
    @end_user = current_end_user
    @end_user.create_notification_follow!(current_end_user)
    redirect_to request.referer
  end

  def destroy
    current_end_user.unfollow(params[:end_user_id])
    redirect_to request.referer
  end

  def followings
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followings
  end

  def followers
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followers
  end
end
