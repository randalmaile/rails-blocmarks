class ChangeDescriptionToText < ActiveRecord::Migration
  def up
    change_column(:bookmarks, :description, :text, limit: nil)
  end

  def down
    change_column(:bookmarks, :description, :string, limit: 255)
  end
end
