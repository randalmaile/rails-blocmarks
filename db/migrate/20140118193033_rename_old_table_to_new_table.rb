class RenameOldTableToNewTable < ActiveRecord::Migration
  def change
    rename_table :categorizes, :tagmaps
  end
end
