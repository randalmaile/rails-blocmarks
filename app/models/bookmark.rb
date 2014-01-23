class Bookmark < ActiveRecord::Base
  attr_accessible :description, :title, :url, :tags_string
  belongs_to :user
  has_many :tagmaps
  has_many :hashtags, :through => :tagmaps, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :url, :format => URI::regexp(%w(http https)), presence: true
  validates :title, presence: true

  def tags_string
    self.hashtags.map {|h| h.tag}.join(" ")
  end

  def tags_string=(values)
    # this is how you change the relation - right through the join table.
    self.hashtags = values.split(" ").map { |s| Hashtag.where(tag: s).first_or_create }
  end

  private


end
