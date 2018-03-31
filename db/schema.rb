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

ActiveRecord::Schema.define(version: 20180331143345) do

  create_table "agencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_agencies_on_name", unique: true
  end

  create_table "currencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "measurement_units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_measurement_units_on_code", unique: true
  end

  create_table "operation_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_operation_types_on_code", unique: true
  end

  create_table "pictures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id", "url"], name: "index_pictures_on_property_id_and_url", unique: true
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "type_id", null: false
    t.bigint "operation_type_id", null: false
    t.integer "floor_area"
    t.bigint "floor_area_unit_id"
    t.integer "plot_area"
    t.bigint "plot_area_unit_id"
    t.integer "rooms"
    t.integer "bathrooms"
    t.integer "parking"
    t.string "city", null: false
    t.string "city_area", null: false
    t.string "region", null: false
    t.decimal "price", precision: 10, scale: 2
    t.bigint "price_currency_id"
    t.date "date", null: false
    t.boolean "published", default: true, null: false
    t.string "external_id", limit: 16
    t.bigint "external_agency_id"
    t.string "external_url"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_agency_id"], name: "fk_rails_ccc7963312"
    t.index ["external_id", "external_agency_id"], name: "index_properties_on_external_id_and_external_agency_id", unique: true
    t.index ["floor_area_unit_id"], name: "fk_rails_6c265a27b9"
    t.index ["operation_type_id"], name: "fk_rails_ac5823d935"
    t.index ["plot_area_unit_id"], name: "fk_rails_edf23fe9ba"
    t.index ["price_currency_id"], name: "fk_rails_d3abcf662a"
    t.index ["source_id"], name: "fk_rails_18dbbd40be"
    t.index ["type_id"], name: "fk_rails_5a5aa39ebe"
  end

  create_table "property_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", limit: 32, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_property_types_on_code", unique: true
  end

  create_table "source_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "source_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "fk_rails_613b3dd2c7"
  end

  create_table "sources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", limit: 16, null: false
    t.string "name", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_sources_on_code", unique: true
  end

  add_foreign_key "pictures", "properties", on_delete: :cascade
  add_foreign_key "properties", "agencies", column: "external_agency_id"
  add_foreign_key "properties", "currencies", column: "price_currency_id"
  add_foreign_key "properties", "measurement_units", column: "floor_area_unit_id"
  add_foreign_key "properties", "measurement_units", column: "plot_area_unit_id"
  add_foreign_key "properties", "operation_types"
  add_foreign_key "properties", "property_types", column: "type_id"
  add_foreign_key "properties", "sources"
  add_foreign_key "source_templates", "sources"
end
