require 'json'

def seed_lanes
  # perform seeding here_
  file = File.join(__dir__, 'rafi.json')
  # binding.pry
  lane_data = File.read(file)
  lanes = JSON.parse(lane_data)

  # p lanes
  coordinate = lanes["features"][0]["geometry"]["coordinates"].first
  street = lanes["features"][0]["properties"]["STREET_NAME"]

  Lane.create(name: street, coordinates: coordinate)


  # lanes["features"].each do |lane|
  #   name = lane["properties"]["STREET_NAME"]
  #   coordinates = lane["geometry"]["coordinates"]

  # end
end

seed_lanes
