json.type "FeatureCollection"
json.features @lanes do |lane|
  json.type "Feature"
  json.properties do
    json.name lane.name
    json.color lane.color
    json.objectid lane.objectid
  end
  json.geometry do
    json.type "MultiLineString"
    json.coordinates JSON.parse(lane.coordinates).split
  end
end
