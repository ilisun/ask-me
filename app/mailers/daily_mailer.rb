class DailyMailer < ApplicationMailer

  def digest(user)
    @user = user
    @url  = 'http://ask-me.borovinskiy.com'
    mail from: "ask-digest@ask-me.borovinskiy.com"
    mail to: user.email
  end
end
