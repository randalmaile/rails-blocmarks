class Hashtag < ActiveRecord::Base
  attr_accessible :tag
  has_many :tagmaps
  has_many :bookmarks, :through => :tagmaps
  validates :tag, presence: true, uniqueness: true
end
