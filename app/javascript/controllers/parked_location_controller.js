import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="parked-location"
export default class extends Controller {
  static targets = ['parked']
  static values = {
    apiKey: String,
    lng: Number,
    lat: Number
  }

  connect() {
    console.log("parked location controller is connected")
    mapboxgl.accessToken = this.apiKeyValue

    // Add map snapshot
    this.map = new mapboxgl.Map({
      container: this.parkedTarget,
      style: "mapbox://styles/mapbox/light-v10",
      center: [this.lngValue, this.latValue],
      zoom: 15
    })

    // Add parked location marker to map
    this.parked_marker = new mapboxgl.Marker()
    .setLngLat([this.lngValue, this.latValue])
    .addTo(this.map);
  }
}
