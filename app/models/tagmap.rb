class Tagmap < ActiveRecord::Base
  attr_accessible :bookmark_id, :hashtag_id, :hashtag_attributes
  belongs_to :bookmark
  belongs_to :hashtag
  accepts_nested_attributes_for :hashtag

  # need to add logic to be able to add a bookmark and assign an existing hashtag
end
