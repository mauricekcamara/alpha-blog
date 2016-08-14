class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?    
  end
  
  def contact
  end
  
  def thank_you
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    UserMailer.contact_form(@email, @name, @message).deliver_now
  end
end
