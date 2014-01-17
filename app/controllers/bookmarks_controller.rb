class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(params[:bookmarks])
    if @bookmark.save
      redirect_to @bookmark, notice: "Your bookmark has been saved."
    else
      flash[:error] = "There was a problem saving your bookmark, please try again."
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(params[:bookmarks])
      redirect_to @bookmark, notice: "Your bookmark has been updated."
    else
      flash[:error] = "There was a problem updating your bookmark, please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      # redirect_to ???, notice: "xxx was deleted successfully.
    else
      flash[:error] = "There was a problem deleting the bookmark"
      render :show
    end
  end

end
