class CreateProperties < ActiveRecord::Migration[5.1]

  def change
    create_table :properties do |t|
      t.string  :title,                          null: false
      t.text    :description,       limit: 2048, null: false
      t.bigint  :type_id,                        null: false
      t.bigint  :operation_type_id,              null: false
      t.integer :floor_area
      t.bigint  :floor_area_unit_id
      t.integer :plot_area
      t.bigint  :plot_area_unit_id
      t.integer :rooms
      t.integer :bathrooms
      t.integer :parking
      t.string  :city,                           null: false
      t.string  :city_area,                      null: false
      t.string  :region,                         null: false
      t.decimal :price,                                      precision: 12, scale: 2
      t.bigint  :price_currency_id
      t.date    :date,                           null: false
      t.boolean :published,                      null: false, default: true
      t.string  :external_id,        limit: 16
      t.bigint  :external_agency_id
      t.string  :external_url

      t.timestamps
    end

    add_foreign_key :properties, :property_types,    column: :type_id
    add_foreign_key :properties, :operation_types
    add_foreign_key :properties, :agencies,          column: :external_agency_id
    add_foreign_key :properties, :currencies,        column: :price_currency_id
    add_foreign_key :properties, :measurement_units, column: :floor_area_unit_id
    add_foreign_key :properties, :measurement_units, column: :plot_area_unit_id
  end

end
