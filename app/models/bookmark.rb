class Bookmark < ActiveRecord::Base
  attr_accessible :description, :title, :url
  belongs_to :user
  has_many :categorizes
  has_many :hashtags, :through => :categorizes

  validates :url, :format => URI::regexp(%w(http https)), presence: true
  validates :title, presence: true
end

