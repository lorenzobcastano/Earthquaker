class AddMagToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_column :features, :mag, :decimal, precision: 5, scale: 2
  end
end
