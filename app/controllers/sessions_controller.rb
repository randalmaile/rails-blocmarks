class SessionsController < ApplicationController
  def new # interesting session already exists - don't have to have a new form???
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id # what does the session object really do?
      redirect_to root_url, :notice => "Logged in"
    else
      flash.now.alert = "Invalid email or password"  # what is flash.now?
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end
end
