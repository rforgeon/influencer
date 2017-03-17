class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :photo, :string
    add_column :users, :name, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :instagram, :string
    add_column :users, :youtube, :string
    add_column :users, :customLink, :string
    add_column :users, :bankNum, :string
    add_column :users, :bankRoutting, :string
    add_column :users, :user_name, :string
  end
end
