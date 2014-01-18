class Tagmap < ActiveRecord::Base
  attr_accessible :bookmark_id, :hashtag_id
  belongs_to :bookmark
  belongs_to :hashtag
end
