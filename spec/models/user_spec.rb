require 'spec_helper'

describe User do
  before do
    @user = create(:user)
    @user2 = create(:user)
  end

  it "should save to the DB when attributes are valid" do 
    @user.save.should eq(true)
  end
  it "should only save users to the db that have unique email address" do
    @user.save
    @user2.save
    @user.email.should_not eq(@user2.email)
  end

  it "should contain all required attributes" do
    @user.email.should_not eq(nil)
    @user.password.should_not eq(nil)
    @user.password_confirmation.should_not eq(nil)
  end

  it "should set password_salt and password_hash in the db" do
    @user.save
    @user.password_salt.should_not eq(nil)
    @user.password_hash.should_not eq(nil)
  end
end
