class Favorite < ActiveRecord::Base
  attr_accessible :bookmark
  belongs_to :bookmark
  belongs_to :user
end
