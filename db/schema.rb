# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151028190550) do

  create_table "accounts", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "auth_token"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "mother_id"
    t.integer  "friend_id"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "chats", ["friend_id"], name: "index_chats_on_friend_id"
  add_index "chats", ["mother_id"], name: "index_chats_on_mother_id"

  create_table "commands", force: :cascade do |t|
    t.string   "name"
    t.string   "action_path"
    t.integer  "step_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "commands", ["step_id"], name: "index_commands_on_step_id"

  create_table "messages", force: :cascade do |t|
    t.integer  "chat_id"
    t.text     "body"
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id"
  add_index "messages", ["from_id"], name: "index_messages_on_from_id"
  add_index "messages", ["to_id"], name: "index_messages_on_to_id"

  create_table "mothers", force: :cascade do |t|
    t.string   "name"
    t.string   "weeks_since_conception"
    t.boolean  "expectant",              default: true
    t.boolean  "opted_in",               default: true
    t.integer  "account_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "phone_number"
    t.boolean  "bot_complete",           default: false
    t.string   "username"
  end

  add_index "mothers", ["account_id"], name: "index_mothers_on_account_id"

  create_table "options", force: :cascade do |t|
    t.string   "key"
    t.text     "text"
    t.integer  "question_id"
    t.integer  "account_id"
    t.integer  "next_step_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "options", ["account_id"], name: "index_options_on_account_id"
  add_index "options", ["question_id"], name: "index_options_on_question_id"

  create_table "progresses", force: :cascade do |t|
    t.integer  "mother_id"
    t.integer  "step_id"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "progresses", ["account_id"], name: "index_progresses_on_account_id"
  add_index "progresses", ["mother_id"], name: "index_progresses_on_mother_id"
  add_index "progresses", ["step_id"], name: "index_progresses_on_step_id"

  create_table "questions", force: :cascade do |t|
    t.text     "text"
    t.integer  "account_id"
    t.integer  "step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["account_id"], name: "index_questions_on_account_id"
  add_index "questions", ["step_id"], name: "index_questions_on_step_id"

  create_table "reminders", force: :cascade do |t|
    t.integer  "tip_id"
    t.integer  "mother_id"
    t.boolean  "sent",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "reminders", ["mother_id"], name: "index_reminders_on_mother_id"
  add_index "reminders", ["tip_id"], name: "index_reminders_on_tip_id"

  create_table "responses", force: :cascade do |t|
    t.integer  "step_id"
    t.text     "text"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responses", ["account_id"], name: "index_responses_on_account_id"
  add_index "responses", ["step_id"], name: "index_responses_on_step_id"

  create_table "steps", force: :cascade do |t|
    t.string   "name"
    t.integer  "account_id"
    t.integer  "wizard_id"
    t.integer  "next_step_id"
    t.string   "step_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "steps", ["account_id"], name: "index_steps_on_account_id"
  add_index "steps", ["wizard_id"], name: "index_steps_on_wizard_id"

  create_table "tips", force: :cascade do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wizards", force: :cascade do |t|
    t.string   "start_keyword"
    t.integer  "account_id"
    t.string   "name"
    t.string   "reset_keyword"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "wizards", ["account_id"], name: "index_wizards_on_account_id"

end
