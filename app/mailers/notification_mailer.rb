class NotificationMailer < ApplicationMailer
  default from: ENV['MAIL_ADDRESS']

  def complete_mail(user)
    @user = user
    mail(subject: "COMPLETE join your address", to: @user.email)
  end

end
