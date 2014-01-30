class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @my_bookmarks = @user.bookmarks
    @favorited_bookmarks = Bookmark.favorited(current_user)
    authorize! :show, @user, message: "You need to be a member to do that"
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

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  def destroy

  end
end
