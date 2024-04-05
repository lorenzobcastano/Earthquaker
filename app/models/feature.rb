class Feature < ApplicationRecord
  has_many :comments
  validates :title, :url, :place, :mag_type, :longitude, :latitude, presence: true
  validates :mag, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10.0 }
  validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }

  def self.create_from_api_data(api_data)
    Feature.create!(
      mag: api_data['properties']['mag'],
      place: api_data['properties']['place'],
      time: Time.at(api_data['properties']['time'] / 1000),
      url: api_data['properties']['url'],
      tsunami: api_data['properties']['tsunami'],
      mag_type: api_data['properties']['magType'],
      title: api_data['properties']['title'],
      longitude: api_data['geometry']['coordinates'][0],
      latitude: api_data['geometry']['coordinates'][1]
    )
  end
end
