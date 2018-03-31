class CreateSources < ActiveRecord::Migration[5.1]

  def change
    create_table :sources do |t|
      t.string :code,     limit: 16, null: false
      t.string :name,     limit: 64, null: false

      t.timestamps
    end

    add_index :sources, :code, unique: true
  end

end
