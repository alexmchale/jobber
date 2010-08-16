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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100815024416) do

  create_table "candidates", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "interview_id"
  end

  create_table "chat_messages", :force => true do |t|
    t.integer  "interview_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "channel",      :default => "public"
  end

  add_index "chat_messages", ["interview_id"], :name => "index_chat_messages_on_interview_id"
  add_index "chat_messages", ["user_id"], :name => "index_chat_messages_on_user_id"

  create_table "documents", :force => true do |t|
    t.integer  "interview_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "documents", ["interview_id"], :name => "index_documents_on_interview_id"

  create_table "interviews", :force => true do |t|
    t.integer  "candidate_id"
    t.datetime "starts_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_code"
    t.integer  "current_document_id"
  end

  create_table "templates", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "templates", ["user_id"], :name => "index_templates_on_user_id"

  create_table "user_interviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "interview_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_interviews", ["interview_id"], :name => "index_user_interviews_on_interview_id"
  add_index "user_interviews", ["user_id"], :name => "index_user_interviews_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
