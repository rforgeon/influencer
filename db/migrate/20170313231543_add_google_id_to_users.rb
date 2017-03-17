class AddGoogleIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ga_user_id, :string
  end
end
