require 'spec_helper'

describe Hashtag do
  it "saves to the db with a tag" do
    @hashtag = build(:hashtag)
    expect(@hashtag).to be_valid
  end

  it "does not save to the db without a tag" do
    @hashtag = build(:hashtag, tag: nil)
    expect(@hashtag).to have(1).errors_on(:tag)
  end

  it "saves to the db if the tag is unique" do
    @hashtag = build(:hashtag)
    @hashtag.save!
    @hashtag2 = build(:hashtag, tag: 'anotherString')
    @hashtag2.save!
    expect(@hashtag2).to be_valid
  end

  it "does not save to the db if the tag is not unique" do
    @hashtag = build(:hashtag)
    @hashtag.save!
    @hashtag2 = build(:hashtag)
    @hashtag2.save
    expect(@hashtag2).to have(1).errors_on(:tag)
  end
end
