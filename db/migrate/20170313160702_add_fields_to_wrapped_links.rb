class AddFieldsToWrappedLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :wrapped_links, :link_clicks, :integer
    add_column :wrapped_links, :rank, :string
    add_column :wrapped_links, :last_clicked, :date
  end
end
