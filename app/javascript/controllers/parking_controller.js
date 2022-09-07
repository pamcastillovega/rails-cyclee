import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['parker']
  static values = {
    apiKey: String,
    markers: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.parkerTarget,
      style: "mapbox://styles/mapbox/light-v10",
      center: [-79.41241607325394, 43.651070],
      zoom: 12
    })

    this.location = new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      trackUserLocation: true,
      showUserHeading: true
    })

    this.map.addControl(this.location, 'top-right')

    this.location.on('geolocate', (e) => {
        new mapboxgl.Marker()
          .setLngLat([ e.coords.longitude, e.coords.latitude ])
          .addTo(this.map)
      })
    }
}
