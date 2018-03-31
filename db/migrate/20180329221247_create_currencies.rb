class CreateCurrencies < ActiveRecord::Migration[5.1]

  def change
    create_table :currencies do |t|
      t.string :code, limit: 32, null: false

      t.timestamps
    end

    add_index :currencies, :code, unique: true
  end

end
