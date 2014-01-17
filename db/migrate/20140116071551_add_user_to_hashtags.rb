class AddUserToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :user_id, :integer
    add_index :hashtags, :user_id
  end
end
