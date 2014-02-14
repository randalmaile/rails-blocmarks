require 'spec_helper'
require 'mail'

describe EmailParser do
  before do
    @url = "http://ferrari.com"
    @user_email = "loquaciousbuzz@gmail.com"
    @tags = "ferrari car luxury taxme"
  end

  context "an email with mixed punctuation within tags in the subject" do
    before do 
      @mixedpunct_tags_message = Mail.read('spec/emails/mixedpunct_tags.eml')
      @parser = EmailParser.new(@mixedpunct_tags_message)
    end

    it "should properly parse user email" do
      expect(@parser.user_email.first).to eq(@user_email)
    end

    it "should properly parse bookmark tags" do
      expect(@parser.tags).to eq(@tags)
    end

    it "should properly parse bookmark url" do
      expect(@parser.url).to eq(@url)
    end
  end

  context "an email with complex formatting in the body + embeded image" do
    before do 
     @complex_body_message = Mail.read('spec/emails/complex_body.eml')
     @parser = EmailParser.new(@complex_body_message)
    end

    it "should properly parse user email" do
    expect(@parser.user_email.first).to eq(@user_email)
    end

    it "should properly parse bookmark tags" do
    expect(@parser.tags).to eq(@tags)
    end

    it "should properly parse bookmark url" do
    expect(@parser.url).to eq(@url)
    end
  end

  context "an email with attachments" do
    before do 
     @attachments_message = Mail.read('spec/emails/attachments.eml')
     @parser = EmailParser.new(@attachments_message)
    end
    it "should properly parse user email" do
      expect(@parser.user_email.first).to eq(@user_email)
    end

    it "should properly parse bookmark tags" do
      expect(@parser.tags).to eq(@tags)
    end

    it "should properly parse bookmark url" do
      expect(@parser.url).to eq(@url)
    end
  end
end