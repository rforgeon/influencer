class AddRegisteredToBrand < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :registered, :boolean
  end
end
