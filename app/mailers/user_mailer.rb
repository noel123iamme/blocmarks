class UserMailer < ApplicationMailer
  default from: 'notifications@blocmarks.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://blocmarks-noel123iamme.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def receive(email)
    @user = email.sender
    @topic = email.subject
    @url = params["body-plain"]
  end
end
