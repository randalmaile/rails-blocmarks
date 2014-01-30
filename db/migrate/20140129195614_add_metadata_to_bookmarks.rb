class AddMetadataToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :metadata, :text
  end
end
