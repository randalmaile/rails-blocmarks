class Bookmark < ActiveRecord::Base
  attr_accessible :description, :title, :url, :tags_string
  belongs_to :user
  has_many :tagmaps
  has_many :hashtags, :through => :tagmaps, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :url, :format => URI::regexp(%w(http https)), presence: true
  default_scope order('created_at Desc')
  scope :favorited, lambda { |user| joins(:favorites).where('favorites.user_id' => user.id) }

  before_save :get_embedly_data
  serialize :metadata, Hash


  def tags_string
    self.hashtags.map {|h| h.tag}.join(" ")
  end

  def tags_string=(values)
    # this is how you change the relation - right through the join table, without having to manipulate it directly
    self.hashtags = values.split(" ").map { |s| Hashtag.where(tag: s).first_or_create }
  end

  def self.through_email(from,subject,url)
    user = User.where(email: from).first
    @bookmark = user.bookmarks.build(url: url, tags_string: subject)
    @bookmark.save
  end

  private

  def get_embedly_data
    self.metadata = EmbedlyUrlService.new(self.url).as_hash
  end
end
