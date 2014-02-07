class EmbedlyUrlService
  def initialize(url)
    @url = url
  end

  def as_hash
    embedly_api = set_key
    obj = embedly_api.oembed(:url => @url)
    { url: obj[0].provider_url, 
              description: obj[0].description,
              title: obj[0].title,
              thumbnail_width: obj[0].thumbnail_width,
              thumbnail_url: obj[0].thumbnail_url }
  end

  private
  
  def set_key
     Embedly::API.new :key => 'b8e7570e696445cab85629255a2bcaaa',
    :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; rmaile2000@yahoo.com)'
  end
end