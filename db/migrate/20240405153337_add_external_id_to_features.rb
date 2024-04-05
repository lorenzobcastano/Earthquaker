class AddExternalIdToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_column :features, :external_id, :string
  end
end
