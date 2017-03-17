class AddGoogleIdToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :ga_brand_id, :string
  end
end
