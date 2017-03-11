class CreateWrappedLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :wrapped_links do |t|
      t.string :link
      t.integer :user_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
