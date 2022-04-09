class Public::ContactsController < ApplicationController

  before_action :authenticate_end_user!

  def new
    @contact = Contact.new
    @contact.nick_name = current_end_user.nick_name
    @contact.email = current_end_user.email
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to thanks_path, notice: 'お問い合わせは正常に送信されました'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:nick_name, :email, :content)
  end
end
