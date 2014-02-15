require 'spec_helper'
require 'mail'

describe Bookmark do
  before do
    @bookmark = build(:bookmark)
    @bookmark_invalid = build(:invalid_bookmark)
  end

  it "saves bookmarks to the db when valid" do
    @bookmark.save!
    expect(@bookmark).to be_valid
  end

  it "will not save to the db with an invalid url" do
    @bookmark.save!
    expect(@bookmark_invalid).to be_invalid
  end

  it "will return favorited bookmarks when favorited scope called" do
    @bookmark.save!
    @bookmark2 = create(:bookmark)
    @user = @bookmark.user
    @user.favorites.create(bookmark: @bookmark)
    @user.favorites.create(bookmark: @bookmark2)
    expect(Bookmark.favorited(@user)).to eq [@bookmark2, @bookmark]
  end

  it "will get embedly data before saving the bookmark" do
    eus = double(as_hash: {})
    EmbedlyUrlService.should_receive(:new).with('http://yahoo.com').and_return(eus)
    @bookmark.url = 'http://yahoo.com'
    @bookmark.save
  end

  it "will get tags_string" do
    @bookmark.save!
    @bookmark.hashtags.create(tag: "dil")
    @bookmark.hashtags.create(tag: "you lowdown")
    expect(@bookmark.tags_string).to eq("dil you lowdown")
  end

  it "will set tags_string" do
    @bookmark.save!
    tag = "hi there"
    @bookmark.tags_string = tag
    hash_tag_array = [Hashtag.where(tag: "hi").first, Hashtag.where(tag: "there").first]
    expect(@bookmark.hashtags).to eq(hash_tag_array)
  end

  it "will serialize metadata and save to the db" do
    @bookmark_serialize = build(:bookmark, url: "https://www.yahoo.com")
    hash = { url: "https://www.yahoo.com", 
      description: "A new welcome to Yahoo. The new Yahoo experience makes it easier to discover the news and information that you care about most. It's the web ordered for you.",
      title: "Yahoo",
      thumbnail_width: 200,
      thumbnail_url: "https://s3.yimg.com/dh/ap/default/130909/y_200_a.png" }
      @bookmark_serialize.metadata = hash
      @bookmark_serialize.save!
      @bookmark_serialize.reload
      expect(@bookmark_serialize.metadata).to eq(hash)  
    end

  context "via email" do
    before do
      @user = User.create(email: "loquaciousbuzz@gmail.com", password: "L0quacious3uzz", password_confirmation: "L0quacious3uzz", name: "Loquacious Buzz")
    end

    it "will create a bookmark with a valid user" do
      @complex_body_message = Mail.read('spec/emails/complex_body.eml')
      @parser = EmailParser.new(@complex_body_message)   
      through_email = Bookmark.create_through_email(@parser.user_email, @parser.tags, @parser.url)
      expect(through_email).to be_valid
    end

    it "will fail to create a bookmark with an invalid user" do
      @unknown_user_message = Mail.read('spec/emails/unknown_user.eml')
      @parser = EmailParser.new(@unknown_user_message)
      through_email = Bookmark.create_through_email(@parser.user_email, @parser.tags, @parser.url)
      expect(through_email).to be_nil
    end
  end
end
