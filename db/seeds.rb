file = File.join(__dir__, 'rafi.json')
lane_data = File.read(file)
lanes = JSON.parse(lane_data)

USER_TYPES = %w[Sport Delivery Commuter]
LANE_TYPES = %w[Protected Painted Contra-Flow Multi-Use Sharrow]

puts 'Cleaning up database'
User.destroy_all
Lane.destroy_all
Review.destroy_all
ParkingLocation.destroy_all
ParkingHistory.destroy_all
Report.destroy_all

puts 'Seeding database'
user_bob = User.create(
  first_name: 'Bob',
  last_name: 'Bobberson',
  email: 'bob.bobberson@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

user_anna = User.create(
  first_name: 'Anna',
  last_name: 'Annason',
  email: 'anna.annason@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

user_yc = User.create(
  first_name: 'YC',
  last_name: 'Low',
  email: 'yc.low@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

user_alex = User.create(
  first_name: 'Alex',
  last_name: 'Alexson',
  email: 'alex.alexson@gmail.com',
  password: 'password',
  user_type: USER_TYPES.sample
)
puts 'Created user'

lane1 = Lane.create(
  name: 'Lane 1',
  lane_type: LANE_TYPES.sample
)
puts 'Created lane'

lane2 = Lane.create(
  name: 'Lane 2',
  lane_type: LANE_TYPES.sample
)
puts 'Created lane'

lane3 = Lane.create(
  name: 'Lane 3',
  lane_type: LANE_TYPES.sample
)
puts 'Created lane'

lane4 = Lane.create(
  name: 'Lane 4',
  lane_type: LANE_TYPES.sample
)
puts 'Created lane'

Review.create(
  rating: rand(5),
  lane: lane1,
  user: user_bob,
  comment: 'Had such a fun time cycling thru this route!! Highly recommend!'
)
puts 'Review created'

Review.create(
  rating: rand(5),
  lane: lane2,
  user: user_anna,
  comment: "Homeless people galore, do not like. Please don't @ me."
)
puts 'Review created'

Review.create(
  rating: rand(5),
  lane: lane3,
  user: user_yc,
  comment: "I'm fine with the event happening around this path but it can't be disrupting if you want peace and quiet."
)
puts 'Review created'

Review.create(
  rating: rand(5),
  lane: lane4,
  user: user_alex,
  comment: "Path is FULL of holes do not recommend."
)
puts 'Review created'

address1 = ParkingLocation.create(
  address: '3685 Bay Street'
)
puts 'Parking Location created'

address2 = ParkingLocation.create(
  address: '3657 Eagle Rd'
)
puts 'Parking Location created'

address3 = ParkingLocation.create(
  address: '4319 Dufferin Street'
)
puts 'Parking Location created'

address4 = ParkingLocation.create(
  address: '401 Tycos Dr'
)
puts 'Parking Location created'

ph1 = ParkingHistory.create(
  parking_location: address1,
  user: user_bob
)
puts 'Parking History created'

ParkingHistory.create(
  parking_location: address2,
  user: user_anna
)
puts 'Parking History created'

ph3 = ParkingHistory.create(
  parking_location: address3,
  user: user_yc
)
puts 'Parking History created'

ParkingHistory.create(
  parking_location: address4,
  user: user_alex
)
puts 'Parking History created'

Report.create(
  parking_location: ph1.parking_location,
  user: ph1.user,
  date: '18/09/2022',
  time: '13:00',
  comment: 'Someone stole my pedals wtf'
)
puts 'Report created'

Report.create(
  parking_location: ph1.parking_location,
  user: ph1.user,
  date: '18/09/2022',
  time: '13:00',
  comment: 'Someone stole my pedals wtf'
)
puts 'Report created'

Report.create(
  parking_location: ph1.parking_location,
  user: ph1.user,
  date: '18/09/2022',
  time: '13:00',
  comment: 'Someone stole my pedals wtf'
)
puts 'Report created'

Report.create(
  parking_location: ph1.parking_location,
  user: ph1.user,
  date: '18/09/2022',
  time: '13:00',
  comment: 'Someone stole my pedals wtf'
)
puts 'Report created'

Report.create(
  parking_location: ph3.parking_location,
  user: ph3.user,
  date: '18/09/2022',
  time: '15:00',
  comment: 'Crazy man asking me to join his MLM business'
)
puts 'Report created'

Report.create(
  parking_location: address2,
  user: user_anna,
  date: '18/09/2022',
  time: '17:00',
  comment: 'Saw someone touching bike chains and sniffing'
)
puts 'Report created'

Report.create(
  parking_location: address4,
  user: user_yc,
  date: '18/09/2022',
  time: '19:00',
  comment: 'Saw Michael Myers lurking in that area yikes'
)
puts 'Report created'

lanes["features"].each do |lane|
  Lane.create(
    coordinates: lane["geometry"]["coordinates"].first,
    name: lane["properties"]["STREET_NAME"],
    lane_type: lane["properties"]["INFRA_HIGHORDER"],
    objectid: lane["properties"]["OBJECTID"]
  )
  puts 'Lanes created'
end

puts 'Finished!'
