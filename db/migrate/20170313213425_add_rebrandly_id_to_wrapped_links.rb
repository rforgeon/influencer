class AddRebrandlyIdToWrappedLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :wrapped_links, :rebrandly_id, :string
  end
end
