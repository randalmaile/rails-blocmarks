require 'spec_helper'

describe UsersController do 
  before :each do
    @user = create(:user)
    session[:user_id] = @user.id
  end

  describe "GET #my_library" do
    it "assigns the current_user users to @my_users" do
      get :my_library, id: @user.id
      assigns(:my_bookmarks).should eq(@user.bookmarks)
    end

    it "renders the :index template" do
      get :my_library, id: @user.id
      response.should render_template :my_library
    end
  end

  describe "GET #favorites" do
    it "assigns user to requested user" do
      get :favorites, id: @user.id
      assigns(:user).should eq(@user)
    end

    it "assigns favorited bookmarks to current_user favorites" do
      get :favorites, id: @user.id
      assigns(:favorited_bookmarks).should eq(Bookmark.favorited(@user))
    end

    it "renders the :show template" do
      get :favorites, id: @user.id
      response.should render_template :favorites
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      get :show, id: @user.id
      assigns(:user).should eq(@user)
    end

    it "renders the :show template" do
      get :show, id: @user.id
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new User to @user" do
      get :new
      assigns(:user).should be_a_new(User) 
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new 
    end  
  end

  describe "POST #create" do 
    def post_valid
      post :create, user: attributes_for(:user)
    end
    def post_invalid
      post :create, user: attributes_for(:invalid_user)
    end

    context "with valid attributes" do 
      it "saves a new user to the database" do
        expect { post_valid }.to change(User, :count).by(1)
      end

      it "should redirect to log_in path" do 
        post_valid
        flash[:notice].should_not be_nil
        response.should redirect_to log_in_path
      end 
    end

    context "with invalid attributes" do 
      it "does not save the new user in the database" do
        expect { post_invalid }.to_not change(User, :count)
      end

      it "re-renders the :new template" do
        post_invalid
        flash[:error].should_not be_nil
        response.should render_template :new 
      end
    end 
  end 

  describe "GET #edit" do
    it "assigns the requested user to @user" do
      get :edit, id: @user.id
      assigns(:user).should eq(@user)
    end

    it "renders the :edit template" do
      get :edit, id: @user.id
      response.should render_template :edit
    end
  end

  describe "PUT #update" do 
    context "with valid attributes" do 
      it "locates the requested @user" do 
        put :update, id: @user, user: attributes_for(:user, name: "Jimbo")
        assigns(:user).should eq(@user)
      end

      it "changes the @user's attributes" do 
        put :update, id: @user, user: attributes_for(:user, name: "Jimbo")
        flash[:notice].should_not be_nil
        @user.reload
        @user.name.should eq("Jimbo")
      end 

      it "redirects to the updated user" do
        put :update, id: @user, user: attributes_for(:user, name: "Jimbo")
        response.should redirect_to @user
      end
    end 

    context "with invalid attributes" do 
      it "locates the requested @user" do 
        put :update, id: @user, user: attributes_for(:invalid_user, name: "Jimbo")
        assigns(:user).should eq(@user)
      end

      it "does not change the @user's attributes" do 
        old_username = @user.name
        put :update, id: @user, user: attributes_for(:invalid_user, name: "Jimbo")
        @user.reload
        @user.name.should eq(old_username)
      end

      it "re-renders the edit method" do 
        put :update, id: @user, user: attributes_for(:invalid_user, name: "Jimbo")
        flash[:error].should_not be_nil
        response.should render_template :edit 
      end
    end 
  end 

  describe 'DELETE #destroy' do 
    it "deletes the user" do 
      expect { 
        delete :destroy, id: @user 
        }.to change(User,:count).by(-1) 
    end 
    it "redirects to root" do 
      delete :destroy, id: @user 
      response.should redirect_to root_path
    end 
  end 

end