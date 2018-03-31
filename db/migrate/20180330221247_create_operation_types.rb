class CreateOperationTypes < ActiveRecord::Migration[5.1]

  def change
    create_table :operation_types do |t|
      t.string :code, limit: 32, null: false

      t.timestamps
    end

    add_index :operation_types, :code, unique: true
  end

end
