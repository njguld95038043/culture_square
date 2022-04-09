class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail to: ENV['ADMIN_GMAIL'], subject: "エンドユーザーからお問い合わせがありました"
  end

end
