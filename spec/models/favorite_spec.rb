require 'spec_helper'

describe Favorite do
  before do
    @user = create(:user)
    @bookmark = create(:bookmark)
    @favorite = @user.favorites.build(bookmark: @bookmark)
  end

  it "saves favorite to the db when valid" do
    @favorite.save!
    expect(@favorite).to be_valid
  end
end
