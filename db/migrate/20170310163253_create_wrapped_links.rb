class CreateWrappedLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :wrapped_links, id: :uuid, default: "uuid_generate_v4()", force: true do |t|
      t.string :link
      t.uuid :user_id
      t.uuid :brand_id
      t.boolean :is_sponsored
      t.decimal :sponsorship_percent

      t.timestamps


    end
  end
end
