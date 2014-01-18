class Bookmark < ActiveRecord::Base
  attr_accessible :description, :title, :url
  belongs_to :user
  has_many :tagmaps
  has_many :hashtags, :through => :tagmaps

  validates :url, :format => URI::regexp(%w(http https)), presence: true
  validates :title, presence: true
end

