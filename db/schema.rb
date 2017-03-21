# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170315181419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "brands", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "photo"
    t.string   "domain"
    t.string   "companyName"
    t.string   "mainContactName"
    t.string   "mainContactEmail"
    t.text     "description"
    t.text     "giftDescription"
    t.integer  "giftReferralThreshold"
    t.decimal  "sponsorSalesPercent"
    t.string   "bankNum"
    t.string   "bankRoutting"
    t.string   "campaignURL"
    t.uuid     "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "registered"
    t.string   "ga_brand_id"
  end

  create_table "collaborators", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "brand_id"
    t.uuid     "user_id"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "photo"
    t.string   "name"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "youtube"
    t.string   "customLink"
    t.string   "bankNum"
    t.string   "bankRoutting"
    t.string   "user_name"
    t.string   "ga_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "wrapped_links", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "link"
    t.uuid     "user_id"
    t.uuid     "brand_id"
    t.boolean  "is_sponsored"
    t.decimal  "sponsorship_percent"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "link_clicks"
    t.string   "rank"
    t.date     "last_clicked"
    t.string   "rebrandly_id"
  end

end
