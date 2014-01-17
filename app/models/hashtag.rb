class Hashtag < ActiveRecord::Base
  attr_accessible :tag, :user
  belongs_to :user

  has_many :categorizes
  has_many :bookmarks, :through => :categorizes

  validates :tag, presence: true
end
