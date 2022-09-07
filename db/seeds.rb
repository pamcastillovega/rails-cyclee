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

address1 = ParkingLocation.create(
  address: '288 Queen St Ws'
)
puts 'Parking Location created'

address2 = ParkingLocation.create(
  address: '70 Lynn Williams St'
)
puts 'Parking Location created'

address3 = ParkingLocation.create(
  address: '20 Sudbury St, Toronto'
)
puts 'Parking Location created'

address4 = ParkingLocation.create(
  address: '100 Harbord St, Toronto'
)
puts 'Parking Location created'

address5 = ParkingLocation.create(
  address: '180 Wellington St W'
)
puts 'Parking Location created'

address6 = ParkingLocation.create(
  address: '1526 Queen St W'
)
puts 'Parking Location created'

address7 = ParkingLocation.create(
  address: '106 Broadview Ave'
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

USERS = [user_bob, user_anna, user_yc, user_alex]

lanes["features"].each do |lane|
  lane_obj = Lane.create(
    coordinates: lane["geometry"]["coordinates"].first,
    name: lane["properties"]["STREET_NAME"],
    lane_type: lane["properties"]["INFRA_HIGHORDER"],
    objectid: lane["properties"]["OBJECTID"]
  )
  puts 'Lane created'

    Review.create(
    rating: rand(1..5),
    lane: lane_obj,
    user: USERS.sample,
    comment: "What an interesting bike lane. Very interesting indeed."
  ) if lane["properties"]["OBJECTID"].even?
  puts 'Review created'
end

all_lanes = Lane.all

all_lanes.each do |lane|
  ratings = []
  lane.reviews.each do |review|
    ratings << review.rating
    average = ratings.length.zero? ? 0 : ratings.sum / ratings.length
    case average
    when 1..2
      lane.color = "#F94C66"
    when 3
      lane.color = "#FFC54D"
    when 3..5
      lane.color = "#53BF9D"
    else
      lane.color = "#616161" if lane.color.nil?
    end
    lane.save!
  end
end

puts 'Finished!'
