require 'spec_helper'
require 'pry'

# spec/controllers/contacts_controller_spec.rb 
require 'spec_helper' 
describe BookmarksController do 
  before :each do
    @bookmark = create(:bookmark)
  end

  describe "GET #index" do 
    it "populates an array of @bookmarks" do
      get :index
      assigns(:bookmarks).should eq([@bookmark])
    end

    it "renders the :index view" do
      get :index 
      response.should render_template :index 
    end
  end 

  describe "GET #show" do 
    it "assigns the requested bookmark to @bookmark" do
      get :show, id: @bookmark
      assigns(:bookmark).should eq(@bookmark)
    end

    it "renders the :show template" do
      get :show, id: @bookmark
      response.should render_template :show 
    end
  end 

  describe "GET #new" do 
    it "assigns a new Bookmark to @bookmark" do
      get :new
      assigns(:bookmark).should be_a_new(Bookmark) #don't need to create a new object here - controller/action does it for you.
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new 
    end
  end 

  describe "POST #create" do 
   before :each do
      def post_create(validity)
        post :create, bookmark: attributes_for(:bookmark) if validity == "valid"
        post :create, bookmark: attributes_for(:invalid_bookmark)
      end
    end
    context "with valid attributes" do 
      it "should create a valid bookmark" do 
       expect{ 
        post_create("valid")
        }.to change(Bookmark,:count).by(1)
      end

      it "should redirect to index with a notice of successful save" do 
        post_create("valid")
        flash[:notice].should_not be_nil
        response.should be_success # revisit!!
        # response.should redirect_to @bookmark 
      end 
    end

      context "with invalid attributes" do 
       it "does not save the new contact in the database" do
        expect {
          post_create("invalid")
          }.to_not change(Bookmark, :count)
        end

        it "re-renders the :new template" do
          post_create("invalid")
          flash[:error].should_not be_nil
          response.should render_template :new 
        end
      end 
    end 

  describe "PUT #update" do 
    before :each do   
      def post_update(url, title, validity) 
        put :update, id: @bookmark, bookmark: attributes_for(:bookmark, url: url, title: title) if validity == "valid"
        put :update, id: @bookmark, bookmark: attributes_for(:invalid_bookmark, url: url, title: title)
      end
    end
    context "with valid attributes" do 
      it "locates the requested @bookmark" do 
        post_update("http://dil.com", "hello", "valid")
        assigns(:bookmark).should eq(@bookmark)
      end

      it "changes the @bookmark's attributes" do 
        post_update("http://dil.com", "hello", "valid")
        flash[:notice].should_not be_nil
        @bookmark.reload
        @bookmark.url.should eq("http://dil.com")
        @bookmark.title.should eq("hello")
      end 

      it "redirects to the updated bookmark" do
        post_update("http://dil.com", "hello", "valid")
        response.should redirect_to @bookmark
      end
    end 

    context "with invalid attributes" do 
      it "locates the requested @bookmark" do 
        put :update, id: @bookmark, bookmark: FactoryGirl.attributes_for(:invalid_bookmark) 
        assigns(:bookmark).should eq(@bookmark)
      end

      it "does not change the @bookmark's attributes" do 
        post_update("http://dil.com", nil, "invalid")
        @bookmark.reload
        @bookmark.url.should_not eq("http://dil.com")
        @bookmark.title.should_not be_nil
      end

      it "re-renders the edit method" do 
        put :update, id: @bookmark, bookmark: FactoryGirl.attributes_for(:invalid_bookmark) 
        flash[:error].should_not be_nil
        response.should render_template :edit 
      end
    end 
  end 
  
  describe 'DELETE destroy' do 
    it "deletes the bookmark" do 
      expect{ 
        delete :destroy, id: @bookmark 
        }.to change(Bookmark,:count).by(-1) 
    end 
    it "redirects to bookmarks#index" do 
      delete :destroy, id: @bookmark 
      response.should redirect_to bookmarks_path
    end 
  end 
end
