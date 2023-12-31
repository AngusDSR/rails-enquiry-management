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

ActiveRecord::Schema[7.0].define(version: 2023_09_21_170709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enquiries", force: :cascade do |t|
    t.string "title"
    t.string "status", default: "new"
    t.string "read_status", default: "unread"
    t.string "first_name"
    t.string "surname"
    t.string "email"
    t.string "phone_number"
    t.string "instagram_handle"
    t.string "preferred_contact_method"
    t.boolean "over_18_confirmation", default: false
    t.text "description"
    t.string "placement"
    t.text "notes"
    t.integer "number_of_sessions", default: 1
    t.datetime "consultation_appointment"
    t.datetime "booking"
    t.datetime "follow_up_session_one"
    t.datetime "follow_up_session_two"
    t.datetime "follow_up_session_three"
    t.datetime "follow_up_session_four"
    t.datetime "follow_up_session_five"
    t.datetime "follow_up_session_six"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
