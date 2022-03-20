class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_end_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = @notifications.where.not(visitor_id: current_end_user.id)

  end

  def destroy
    current_end_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

end