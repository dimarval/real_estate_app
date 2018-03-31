class CreateMeasurementUnits < ActiveRecord::Migration[5.1]

  def change
    create_table :measurement_units do |t|
      t.string :code, limit: 32, null: false

      t.timestamps
    end

    add_index :measurement_units, :code, unique: true
  end

end
