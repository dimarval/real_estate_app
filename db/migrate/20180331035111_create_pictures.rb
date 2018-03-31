class CreatePictures < ActiveRecord::Migration[5.1]

  def change
    create_table :pictures do |t|
      t.bigint :property_id,  null: false
      t.string :url,          null: false

      t.timestamps
    end

    add_index :pictures, [:property_id, :url], unique: true

    add_foreign_key :pictures, :properties, on_delete: :cascade
  end

end
