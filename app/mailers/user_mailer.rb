class UserMailer < ActionMailer::Base
  default from: 'The QVB Project'
 
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the QVB Project')
  end
end