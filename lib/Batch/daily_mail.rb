class Batch::DailyMail
  def self.daily_mail
    # User.all.each do |user|
    #   NotificationMailer.batch_mail(user).deliver
    # end
    p "メールを送信しました。"
  end
end
