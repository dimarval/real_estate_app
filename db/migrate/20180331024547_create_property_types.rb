class CreatePropertyTypes < ActiveRecord::Migration[5.1]

  def change
    create_table :property_types do |t|
      t.string :code, limit: 32, null: false

      t.timestamps
    end

    add_index :property_types, :code, unique: true
  end

end
