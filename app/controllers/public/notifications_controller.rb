class Public::NotificationsController < ApplicationController

  def index
    @notification = current_end_user.passive_notifications
    Notification.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = Notification.all
  end

  def destroy_all
    @notifications = current_end_user.passive_notifications.destroy_all
    redirect_to end_users_notifications_path
  end

end
