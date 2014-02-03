require 'spec_helper'
describe UsersController do 
  before :each do
    @user = create(:user)
    session[:user_id] = @user.id
  end

  describe "GET #my_library" do
    it "assigns the current_user bookmarks to @my_bookmarks" do
      get "/favorites/:id"
      assigns(@my_bookmarks).should eq([@user.bookmarks])
    end

    it "renders the :index template" do
      get "/favorites/:id"
      response.should render_template :my_library
    end
  end
end