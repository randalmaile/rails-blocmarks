class FavoritesController < ApplicationController

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    favorite = current_user.favorites.create(bookmark: @bookmark)
    if favorite.valid?
      flash[:notice] = "Favorited post"
      redirect_to :back
    else
      flash[:error] = "Unable to add favorite."
      redirect_to :back
    end
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    if favorite.destroy
      flash[:notice] = "Removed favorite."
      redirect_to :back
    else
      flash[:error] = "Unable to remove favorite. Please try again."
      redirect_to :back
    end
  end
end
