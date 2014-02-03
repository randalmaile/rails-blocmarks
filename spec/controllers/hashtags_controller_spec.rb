require 'spec_helper' 
describe HashtagsController do 
  before :each do
    @hashtag = create(:hashtag)
  end

 describe "GET #index" do 
    it "assigns the requested hashtag to @hashtag" do
      get :index
      assigns(:hashtags).should eq([@hashtag])
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end
  end 

  describe "GET #show" do 
    it "assigns the requested hashtag to @hashtag" do
      get :show, id: @hashtag
      assigns(:hashtag).should eq(@hashtag)
    end

    it "renders the :show template" do
      get :show, id: @hashtag
      response.should render_template :show
    end
  end 
end