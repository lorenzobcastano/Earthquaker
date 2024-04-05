class AddExternalUrlToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_column :features, :external_url, :string
  end
end
