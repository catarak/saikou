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

ActiveRecord::Schema.define(version: 20141201201421) do

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chart_weeks", force: true do |t|
    t.integer  "chart_id"
    t.integer  "week_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chart_weeks", ["chart_id"], name: "index_chart_weeks_on_chart_id"
  add_index "chart_weeks", ["week_id"], name: "index_chart_weeks_on_week_id"

  create_table "charts", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "charts", ["country_id"], name: "index_charts_on_country_id"

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "song_charts", force: true do |t|
    t.integer  "song_id"
    t.integer  "chart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "song_charts", ["chart_id"], name: "index_song_charts_on_chart_id"
  add_index "song_charts", ["song_id"], name: "index_song_charts_on_song_id"

  create_table "songs", force: true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id"

  create_table "week_countries", force: true do |t|
    t.integer  "week_id"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "week_countries", ["country_id"], name: "index_week_countries_on_country_id"
  add_index "week_countries", ["week_id"], name: "index_week_countries_on_week_id"

  create_table "week_years", force: true do |t|
    t.integer  "week_id"
    t.integer  "year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "week_years", ["week_id"], name: "index_week_years_on_week_id"
  add_index "week_years", ["year_id"], name: "index_week_years_on_year_id"

  create_table "weeks", force: true do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "years", force: true do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
