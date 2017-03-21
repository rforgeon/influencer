class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands, id: :uuid, default: "uuid_generate_v4()", force: true do |t|
      t.string :photo
      t.string :domain
      t.string :companyName
      t.string :mainContactName
      t.string :mainContactEmail
      t.text :description
      t.text :giftDescription
      t.integer :giftReferralThreshold
      t.decimal :sponsorSalesPercent
      t.string :bankNum
      t.string :bankRoutting
      t.string :campaignURL
      t.uuid :user_id

      t.timestamps


    end
  end
end
