require 'spec_helper'

describe User do
  before do
    @user = build(:user, email: "admin@example.com")
    @user2 = build(:user, email: "admin@example.com")
  end

  it "should save to the DB when attributes are valid" do 
    @user.save.should eq(true)
  end

  it "should only save users to the db that have unique email address" do
    @user.save!
    @user2.save!
    @user2.should_not be_valid
  end

  it "should contain all required attributes" do
    @user.save!
    @user.should be_valid
  end

  it "should set password_salt and password_hash in the db" do
    @user.save!
    @user.password_salt.should_not eq(nil)
    @user.password_hash.should_not eq(nil)
  end
end
