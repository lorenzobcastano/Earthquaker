class AddFeatureIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :feature_id, :integer
    add_index :comments, :feature_id
  end
end
