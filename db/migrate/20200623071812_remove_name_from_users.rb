class RemoveNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :profile_imege_id, :integer
  end
end
