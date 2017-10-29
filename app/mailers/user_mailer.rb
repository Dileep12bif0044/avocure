class UserMailer < ApplicationMailer
    default from: "dileepk025@gmail.com"

  def signup_confirmation(user)
    @user = user
    @url  = 'http://localhost:3000/user/login'
    mail(to: 'dileepk025@gmail.com', subject: 'Registration confirmation', body: "World!!")
  end

end
