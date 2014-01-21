class Bookmark < ActiveRecord::Base
  attr_accessible :description, :title, :url, :tagmaps_attributes
  belongs_to :user
  has_many :tagmaps, inverse_of: :bookmark
  has_many :hashtags, :through => :tagmaps
  accepts_nested_attributes_for :tagmaps, allow_destroy: true
  # accepts_nested_attributes_for :tagmaps, dependent: destroy


  # after_destroy :destroy_orphaned_children

  validates :url, :format => URI::regexp(%w(http https)), presence: true
  validates :title, presence: true


  private

  # def destroy_orphaned_children
  #   hashtags.each do |hashtag|
  #     hashtag.destroy if hashtag.bookmarks.empty?
  #   end
  # end
end
