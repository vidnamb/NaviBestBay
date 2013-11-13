class UserMailer < ActionMailer::Base
  default from: "bullfrog.game@gmail.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://bbnavi.heroku.com/user?'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end