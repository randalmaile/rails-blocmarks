class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end
end
