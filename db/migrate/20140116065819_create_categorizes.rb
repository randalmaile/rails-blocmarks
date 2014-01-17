class CreateCategorizes < ActiveRecord::Migration
  def change
    create_table :categorizes do |t|
      t.integer :bookmark_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
