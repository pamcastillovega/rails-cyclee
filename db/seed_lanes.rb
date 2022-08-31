require 'json'
require 'pry-byebug'
def seed_lanes
  # perform seeding here_
  file = File.join(__dir__, 'rafi.json')
  # binding.pry
  lane_data = File.read(file)
  lanes = JSON.parse(lane_data)

  # p lanes
  pp lanes["features"][0]["geometry"]["coordinates"].first

  lanes["features"].each do |lane|
    name = lane["properties"]["STREET_NAME"]
    coordinates = lane["geometry"]["coordinates"]
    SeedLanes(name, coordinates = [[]])
  end
end

seed_lanes
