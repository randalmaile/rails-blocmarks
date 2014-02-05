require 'spec_helper'

describe Bookmark do
  before do
    @bookmark = create(:bookmark)
    @bookmark_invalid = build(:invalid_bookmark)
    @user = @bookmark.user
  end

  it "saves bookmarks to the db when valid" do
    expect(@bookmark).to be_valid
  end

  it "will not save to the db with an invalid url" do
    expect(@bookmark_invalid).to be_invalid
  end

  it "will return favorited bookmarks when favorited scope called" do
    @bookmark2 = create(:bookmark)
    @user.favorites.create(bookmark: @bookmark)
    @user.favorites.create(bookmark: @bookmark2)
    expect(Bookmark.favorited(@user)).to eq [@bookmark2, @bookmark]
  end

  it "will get embedly_date before saving the bookmark" do

  end

  it "will get tag_string" do

  end

  it "will set tag_string" do

  end

  it "will serialize metadata and save to the db" do
    
  end

end
