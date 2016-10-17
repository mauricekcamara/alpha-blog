class UserMailer < ApplicationMailer
  default from: "alzebo2000@gmail.com"

  def contact_form(email, name, message)
    @name = name
    @message = message
    @email = email

      mail(:from => email,
           :to => 'mauricekcamara@gmail.com',
           :subject => "a new contact form message from #{name}")
  end
end