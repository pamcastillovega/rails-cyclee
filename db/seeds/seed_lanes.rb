require 'json'

def seed_lanes
  # perform seeding here_
  file = File.join(__dir__, 'rafi.json')
  lane_data = File.read(file)
  lanes = JSON.parse(lane_data)

  # p lanes
  first_coordinate = lanes["features"][1]["geometry"]["coordinates"].first
  first_street = lanes["features"][0]["properties"]["STREET_NAME"]

  # pp first_coordinate
  # pp first_street

  lanes["features"].each do |lane|
    Lane.create(coordinates: lane["geometry"]["coordinates"].first, name: lane["properties"]["STREET_NAME"], lane_type: lane["properties"]["INFRA_HIGHORDER"], objectid: lane["properties"]["OBJECTID"] )
  end

  # coordinates = []
  # lanes["features"].each { |lane| coordinates << lane["geometry"]["coordinates"] }

  # streets = []
  # lanes["features"].each { |lane| streets << lane["properties"]["STREET_NAME"] }
  # # pp streets


  # Lane.create(name: streets.each { |street| street }, coordinates: coordinates.each { |coordinate| coordinate })

  # Lane.create(name: first_street, coordinates: first_coordinate)

  # lanes["features"].each do |lane|
  #   name = lane["properties"]["STREET_NAME"]
  #   coordinates = lane["geometry"]["coordinates"]

  # end
end

seed_lanes
