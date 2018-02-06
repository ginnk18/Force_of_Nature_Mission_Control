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

ActiveRecord::Schema.define(version: 20180131200210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_emails", force: :cascade do |t|
    t.string "to_recipients"
    t.text "email_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "email_templates", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.string "from"
    t.string "bcc"
    t.string "cc"
    t.string "slug", null: false
    t.text "body", null: false
    t.text "template", null: false
    t.index ["slug"], name: "index_email_templates_on_slug"
  end

  create_table "event_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.time "start_time"
    t.time "end_time"
    t.date "date"
    t.string "location"
    t.text "additional_info"
    t.string "attachment_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_category_id"
    t.bigint "creator_id"
    t.bigint "lead_id"
    t.string "google_event_id"
    t.bigint "team_id"
    t.integer "data_captain_id"
    t.integer "sign_up_goals"
    t.integer "show_up_goals"
    t.integer "signature_goals"
    t.integer "sign_up_outcome"
    t.integer "show_up_outcome"
    t.integer "signature_outcome"
    t.integer "canvas_captain_id"
    t.integer "shift_manager_id"
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["event_category_id"], name: "index_events_on_event_category_id"
    t.index ["lead_id"], name: "index_events_on_lead_id"
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "team_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_category_id"
    t.bigint "team_lead_id"
    t.index ["team_category_id"], name: "index_teams_on_team_category_id"
    t.index ["team_lead_id"], name: "index_teams_on_team_lead_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "user_teams", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_category_id"
    t.string "phone_number"
    t.text "additional_info"
    t.boolean "previous_volunteer", default: false
    t.boolean "contacted", default: false
    t.string "reset_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_category_id"], name: "index_users_on_user_category_id"
  end

  add_foreign_key "events", "event_categories"
  add_foreign_key "events", "teams"
  add_foreign_key "teams", "team_categories"
  add_foreign_key "user_events", "events"
  add_foreign_key "user_events", "users"
  add_foreign_key "user_teams", "teams"
  add_foreign_key "user_teams", "users"
  add_foreign_key "users", "user_categories"
end
