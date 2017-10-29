class UserMailer < ApplicationMailer
    default from: "dileepk025@gmail.com"

  def signup_confirmation(name,email)
    @user = name
    @url  = 'http://localhost:3000/user/login'
    mail(to: email, subject: 'Registration confirmation', body: "World!!")
  end

end
