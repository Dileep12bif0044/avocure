class AvocureMailer < ApplicationMailer
	default from: "dileepk025@gmail.com"

  def avocure_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end
