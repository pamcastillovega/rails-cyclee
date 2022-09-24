file = File.join(__dir__, 'rafi.json')
lane_data = File.read(file)
lanes = JSON.parse(lane_data)

USER_TYPES = %w[Sport Delivery Commuter]
LANE_TYPES = %w[Protected Painted Contra-Flow Multi-Use Sharrow]

puts 'Cleaning up database...'
User.destroy_all
Lane.destroy_all
Review.destroy_all
ParkingLocation.destroy_all
ParkingHistory.destroy_all
Report.destroy_all

puts 'Seeding database...'

# Create seed users
User.create(
  first_name: 'Bob',
  last_name: 'Bobberson',
  email: 'bob.bobberson@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

User.create(
  first_name: 'Anna',
  last_name: 'Annason',
  email: 'anna.annason@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

User.create(
  first_name: 'YC',
  last_name: 'Low',
  email: 'yc.low@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

User.create(
  first_name: 'Alex',
  last_name: 'Alexson',
  email: 'alex.alexson@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

# Create seed parking locations
ParkingLocation.create(
  address: '288 Queen St Ws'
)
puts 'Created parking location'

ParkingLocation.create(
  address: '70 Lynn Williams St'
)
puts 'Created parking location'

ParkingLocation.create(
  address: '20 Sudbury St, Toronto'
)
puts 'Created parking location'

ParkingLocation.create(
  address: '100 Harbord St, Toronto'
)
puts 'Created parking location'

ParkingLocation.create(
  address: '180 Wellington St W'
)
puts 'Created parking location'

ParkingLocation.create(
  address: '1526 Queen St W'
)
puts 'Created parking location'

ParkingLocation.create(
  address: '106 Broadview Ave'
)
puts 'Created parking location'

# Add lanes to map
lanes["features"].each do |lane|
  Lane.create(
    coordinates: lane['geometry']['coordinates'].first,
    name: "#{lane['properties']['STREET_NAME']} (#{lane['properties']['FROM_STREET']} - #{lane['properties']['TO_STREET']})",
    lane_type: lane['properties']['INFRA_HIGHORDER'],
    objectid: lane['properties']['OBJECTID']
  )
  puts 'Lane created'
end

puts 'Finished!'

# all_lanes = Lane.all

# all_lanes.each do |lane|
#   ratings = []
#   lane.reviews.each do |review|
#     ratings << review.rating
#     average = ratings.length.zero? ? 0 : ratings.sum / ratings.length
#     case average
#     when 1..2
#       lane.color = "#DB4437"
#     when 3
#       lane.color = "#F4B400"
#     when 3..5
#       lane.color = "#0F9D58"
#     else
#       lane.color = "#616161" if lane.color.nil?
#     end
#     lane.save!
#   end
# end
