class NotificationMailer < ApplicationMailer
  default from: ENV['MAIL_ADDRESS']

  def complete_mail(user)
    @user = user
    mail(subject: "COMPLETE join your address", to: @user.email)
  end

  def batch_mail(user)
    @user = user
    mail(subject: "本読んでますか！？", to: @user.email)
  end
  



end
