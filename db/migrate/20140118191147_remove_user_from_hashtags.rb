class RemoveUserFromHashtags < ActiveRecord::Migration
  def change
    remove_column :hashtags, :user_id, :integer
  end
end
