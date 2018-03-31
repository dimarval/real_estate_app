class CreateSourceTemplates < ActiveRecord::Migration[5.1]

  def change
    create_table :source_templates do |t|
      t.bigint :source_id, null: false
      t.text   :content,   null: false

      t.timestamps
    end

    add_foreign_key :source_templates, :sources
  end

end
