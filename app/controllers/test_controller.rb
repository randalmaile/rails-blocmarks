 
class TestController < ApplicationController

  def embedly
    embedly_api = Embedly::API.new :key => 'b8e7570e696445cab85629255a2bcaaa',
        :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; rmaile2000@yahoo.com)'
    # obj = embedly_api.oembed :url => 'http://yfrog.com/ng41306327j'
    obj = embedly_api.oembed :url => 'http://www.smashingmagazine.com/2014/01/20/dealing-with-workaholism-on-web-teams/'
    @hash = { url: obj[0].provider_url, 
              description: obj[0].description,
              title: obj[0].title,
              thumbnail_width: obj[0].thumbnail_width,
              thumbnail_url: obj[0].thumbnail_url
             }  
    # binding.pry
  end
end


 # thumbnail_width=3872,
 #  height=2592, 
 #  width=3872, 
 #  thumbnail_url="http://a.yfrog.com/img844/1410/41306327.jpg", 
 #  url="http://a.yfrog.com/img844/1410/41306327.jpg", 
 #  version="1.0", provider_name="YFrog", type="photo", 
 #  thumbnail_height=2592>