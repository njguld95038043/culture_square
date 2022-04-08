class Public::ContactsController < ApplicationController

  before_action :authenticate_end_user!

  def new
    @contact = Contact.new
    @end_user = current_end_user
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, contact_params[:email]).deliver
      redirect_to root_path, notice: 'お問い合わせ内容を送信しました'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:nick_name, :email, :content)
  end
end
