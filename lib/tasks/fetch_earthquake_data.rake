namespace :fetch do
  desc "Fetch earthquake data from USGS"
  task earthquake_data: :environment do
    require 'httparty'
    require 'json'

    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    features = data['features']

    features.each do |feature|
      properties = feature['properties']
      coordinates = feature['geometry']['coordinates']

      # Obtener los valores necesarios
      id = feature['id']
      mag = properties['mag']
      place = properties['place']
      time = properties['time']
      url = properties['url']
      tsunami = properties['tsunami']
      mag_type = properties['magType']
      title = properties['title']
      longitude = coordinates[0]
      latitude = coordinates[1]

      # Validar los valores
      next if title.nil? || url.nil? || place.nil? || mag_type.nil? || coordinates.nil?
      next if mag < -1.0 || mag > 10.0 || latitude < -90.0 || latitude > 90.0 || longitude < -180.0 || longitude > 180.0

      # Persistir los datos en la base de datos
      Feature.find_or_create_by(title: title) do |f|
        f.mag = mag
        f.place = place
        f.time = Time.at(time / 1000) # Convertir de milisegundos a segundos
        f.url = url
        f.tsunami = tsunami
        f.mag_type = mag_type
        f.title = title
        f.longitude = longitude
        f.latitude = latitude
      end
    end
  end
end
