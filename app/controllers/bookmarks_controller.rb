class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
    @build_hashtag = @bookmark.tagmaps.build.build_hashtag
  end

  def create
    # @hashtag = current_user.bookmarks.hashtags.where(tag: )
    @bookmark = current_user.bookmarks.build(params[:bookmark])
    if @bookmark.save
      flash[:notice] =  "Your bookmark has been saved."
      redirect_to @bookmark
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
    if @bookmark.update_attributes(params[:bookmark])
      redirect_to @bookmark, notice: "Your bookmark has been updated."
    else
      flash[:error] = "There was a problem updating your bookmark, please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      redirect_to hashtags_path, notice: "Bookmark was deleted successfully."
    else
      flash[:error] = "There was a problem deleting the bookmark"
      render :show
    end
  end

end
