class SessionsController < ApplicationController
  skip_before_action :confirm_user_logged_in, only: [:new, :create]

  def new
  end

  # Log in functionality
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # authenticate method automatically decrpyts hashed password
    if @user && @user.authenticate(params[:session][:password]) 
      log_in @user # To log in a user part of log in flow
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
