class RemoveUserAndGroupsFromNotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :notes, :user_id, :integer
    remove_column :notes, :group_id, :integer
  end
end
