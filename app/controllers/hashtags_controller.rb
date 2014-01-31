class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.all
  end

  def show
    @hashtag = Hashtag.find(params[:id])
    @bookmarks = @hashtag.bookmarks.paginate(page: params[:page], per_page: 3)
  end
end
