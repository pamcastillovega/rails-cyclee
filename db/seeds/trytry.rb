require 'json'
require 'pry-byebug'

def update_json

  file = File.join(__dir__, 'rafi.json')
  lane_data = File.read(file)
  jsonlanes = JSON.parse(lane_data)
  count = 0
  all_lanes = Lane.all
  all_lanes.each do |model|
    rating_array = []
    model.reviews.each do |review|
      rating_array << review.rating
      average_rating = (rating_array.sum / rating_array.length) if rating_array.any?
      jsonlanes["features"].each do |lanes|
        if model.objectid == lanes["properties"]["OBJECTID"].to_s
          case average_rating
          when 1
            lanes["properties"]["color"] = "#ff0000"
          when 2
            lanes["properties"]["color"] = "#FFA500"
          when 3
            lanes["properties"]["color"] = "#FFFF00"
          when 4
            lanes["properties"]["color"] = "#0000FF"
          when 5
            lanes["properties"]["color"] = "#00FF00"
          end
        else
          lanes["properties"]["color"] = "#888" if lanes["properties"]["color"].nil?
        end
      end
    end
  end
  # File.write('./sample-data.json', JSON.dump(jsonlanes))
  File.open('./test.geojson', "wb") do |file|
    file.write(JSON.generate(jsonlanes))
  end
end

update_json
