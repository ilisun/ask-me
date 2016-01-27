class DailyMailer < ApplicationMailer

  def digest(user)
    @user = user
    @url  = 'http://ask-me.borovinskiy.com'
    mail to: user.email
  end
end
