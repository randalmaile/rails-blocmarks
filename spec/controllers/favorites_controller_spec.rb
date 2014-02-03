require 'spec_helper'

describe FavoritesController do
  before :each do
    @favorite = create(:favorite)
    @bookmark = @favorite.bookmark
    session[:user_id] = @favorite.user.id 
    request.env["HTTP_REFERER"] = "source_page" #used to set referring page for the redirect to :back test
  end

  describe "POST create" do 
    it "saves a new favorite to the database" do 
      expect{ post :create, bookmark_id: @bookmark.id,  favorite: attributes_for(:favorite) }.to change(Favorite,:count).by(1) 
    end

    it "redirects ':back' to the source page" do
      post :create, bookmark_id: @bookmark.id,  favorite: attributes_for(:favorite)
      response.should redirect_to "source_page"
    end
  end 

  describe 'DELETE destroy' do 
    it "deletes the favorite" do 
      expect { delete :destroy, bookmark_id: @bookmark.id, id: @favorite }.to change(Favorite,:count).by(-1) 
    end 

    it "redirects ':back' to the source page" do
      delete :destroy, bookmark_id: @bookmark.id, id: @favorite
      response.should redirect_to "source_page"
    end 
  end 
end
