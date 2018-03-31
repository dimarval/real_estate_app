class AddSourceIdToProperties < ActiveRecord::Migration[5.1]

  def change
    add_column :properties, :source_id, :bigint, after: :external_url

    add_foreign_key :properties, :sources
  end

end
