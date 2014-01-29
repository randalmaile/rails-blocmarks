class Bookmark < ActiveRecord::Base
  attr_accessible :description, :title, :url, :tags_string
  belongs_to :user
  has_many :tagmaps
  has_many :hashtags, :through => :tagmaps, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :url, :format => URI::regexp(%w(http https)), presence: true
  scope :favorited, lambda { |user| joins(:favorites).where(user_id: user.id) }


  def tags_string
    self.hashtags.map {|h| h.tag}.join(" ")
  end

  def tags_string=(values)
    # this is how you change the relation - right through the join table.
    self.hashtags = values.split(" ").map { |s| Hashtag.where(tag: s).first_or_create }
  end

  def embedly 
    embedly_api = set_key
    obj = embedly_api.oembed(:url => self.url)
    @urlEmbed = { url: obj[0].provider_url, 
              description: obj[0].description,
              title: obj[0].title,
              thumbnail_width: obj[0].thumbnail_width,
              thumbnail_url: obj[0].thumbnail_url }
  end

  # def self.embedly  Was wondering if I could make a collection of all the embedlified bookmarks!! 
  #   url_array = []
  #   self.all.each do |bookmark|
  #     url_array << bookmark.url
  #   end
  #   embedly_api = self.new_embedly_api  
  #   objs = embedly_api.oembed(urls: url_array)
  #   json_obj = JSON.pretty_generate(objs.collect{|o| o.marshal_dump})
  #   binding.pry
  # end

private
  def set_key
     Embedly::API.new :key => 'b8e7570e696445cab85629255a2bcaaa',
    :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; rmaile2000@yahoo.com)'
  end
end
