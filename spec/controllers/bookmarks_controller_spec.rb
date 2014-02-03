require 'spec_helper' 
describe BookmarksController do 
  before :each do
    @bookmark = create(:bookmark)
    session[:user_id] = @bookmark.user.id 
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
      assigns(:bookmark).should be_a_new(Bookmark) 
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new 
    end
  end 

  describe "POST #create" do 
    def post_valid
      post :create, bookmark: attributes_for(:bookmark)
    end

    def post_invalid
      post :create, bookmark: attributes_for(:invalid_bookmark)
    end

    context "with valid attributes" do 
      it "creates a new bookmark" do
        expect { post_valid }.to change(Bookmark, :count).by(1)
      end

      it "should redirect to hashtags index" do 
        post_valid
        flash[:notice].should_not be_nil
        response.should redirect_to hashtags_path
      end 
    end

    context "with invalid attributes" do 
      it "does not save the new bookmark in the database" do
        expect {
          post_invalid
          }.to_not change(Bookmark, :count)
        end

        it "re-renders the :new template" do
          post_invalid
          flash[:error].should_not be_nil
          response.should render_template :new 
        end
      end 
    end 

    describe "PUT #update" do 
      def put_valid
        put :update, id: @bookmark, bookmark: attributes_for(:bookmark)
      end

      def put_invalid
        put :update, id: @bookmark, bookmark: attributes_for(:invalid_bookmark)
      end

      context "with valid attributes" do 
        it "locates the requested @bookmark" do 
          put_valid
          assigns(:bookmark).should eq(@bookmark)
        end

        it "changes the @bookmark's attributes" do 
          put_valid
          flash[:notice].should_not be_nil
          @bookmark.reload
          @bookmark.url.should eq("http://google.com")
        end 

        it "redirects to the updated bookmark" do
          put_valid
          response.should redirect_to @bookmark
        end
      end 

      context "with invalid attributes" do 
        it "locates the requested @bookmark" do 
          put_invalid
          assigns(:bookmark).should eq(@bookmark)
        end

        it "does not change the @bookmark's attributes" do 
          put :update, id: @bookmark, bookmark: attributes_for(:bookmark, url: "google.com")
          @bookmark.reload
          @bookmark.url.should_not eq("http://google.com")
        end

        it "re-renders the edit method" do 
          put_invalid
          flash[:error].should_not be_nil
          response.should render_template :edit 
        end
      end 
    end 

    describe 'DELETE destroy' do 
      it "deletes the bookmark" do 
        expect { 
          delete :destroy, id: @bookmark 
          }.to change(Bookmark,:count).by(-1) 
        end 
        it "redirects to hashtags index" do 
          delete :destroy, id: @bookmark 
          response.should redirect_to hashtags_path
        end 
      end 
    end
