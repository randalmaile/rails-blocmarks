class HashtagsController < ApplicationController
  def index
  @hashtags = Hashtag.all
  @hashtag_groups = @hashtags.group_by { |t| t.tag }

  end

  def show
    @hashtag = Hashtag.find(params[:id])
    @bookmarks = @hashtag.bookmarks
  end

  def new
    @hashtag = Hashtag.new
  end

  def create
    @hashtag = Hashtag.new(params[:hashtags])
    if @hashtag.save
      redirect_to @hashtag, notice: "Your hashtag has been saved."
    else
      flash[:error] = "There was a problem saving your hashtag, please try again."
      render :new
    end
  end

  def edit
    @hashtag = Hashtag.find(params[:id])
  end

  def update
    @hashtag = Hashtag.find(params[:id])
    if @hashtag.update_attributes(params[:hashtags])
      redirect_to @hashtag, notice: "Your hashtag has been updated."
    else
      flash[:error] = "There was a problem updating your hashtag, please try again."
      render :edit
    end
  end

  def destroy
    @hashtag = Hashtag.find(params[:id])
    if @hashtag.destroy
      # redirect_to ???, notice: "xxx was deleted successfully.
    else
      flash[:error] = "There was a problem deleting the hashtag"
      render :show
    end
  end
end
