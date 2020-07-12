class RemovePasswordResetsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :reset_digest, :string
    remove_column :users, :reset_sent_at, :datetime
  end
end
