# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_07_161710) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "search_queries", force: :cascade do |t|
    t.string "query"
    t.string "ip"
    t.string "session_id"
    t.datetime "finalized_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["finalized_at"], name: "index_search_queries_on_finalized_at"
    t.index ["query"], name: "index_search_queries_on_query"
  end

  create_table "search_sessions", force: :cascade do |t|
    t.string "ip"
    t.string "session_id"
    t.string "last_query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip", "session_id"], name: "index_search_sessions_on_ip_and_session_id", unique: true
  end
end
