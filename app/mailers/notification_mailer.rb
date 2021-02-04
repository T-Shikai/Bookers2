class NotificationMailer < ApplicationMailer
  default from: 'tatsuroshikai@gmail.com'

  def complete_mail
    mail(subject: "COMPLETE join your address", to: 'tatsuroshikai@gmail.com')
  end

end
