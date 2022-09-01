import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/light-v10",
      center: [-79.41241607325394, 43.651070],
      zoom: 12
    })

    this.map.on('load', this.#loadRoutes)

    this.directions = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: 'metric',
      profile: 'mapbox/cycling',
      interactive: false
    });

    this.location = new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      trackUserLocation: true,
      showUserHeading: true
    })


    // this.#addMarkersToMap()
    // this.#fitMapToMarkers()

    this.map.addControl(this.directions, 'top-left')
    this.map.addControl(this.location, 'top-right')

  }

  removeDirections () {
    this.map.removeControl(this.directions);
  }

  #loadRoutes(e) {
    // console.log(e.target);
    e.target.addSource('route', {
      'type': 'geojson',
      'data': 'https://lionheartsg.github.io/data/bike-network-data-4326.geojson'
    });

    e.target.addLayer({
      'id': 'route',
      'type': 'line',
      'source': 'route',
      'layout': {
      'line-join': 'round',
      'line-cap': 'round'
    },

    });

    e.target.on('click', 'route', (e) => {
      const coordinates = e.features[0].geometry.coordinates;
      console.log(coordinates);
      const type = e.features[0].properties.INFRA_HIGHORDER;
      console.log(type);
      const name = `${e.features[0].properties.STREET_NAME} (${e.features[0].properties.FROM_STREET} - ${e.features[0].properties.TO_STREET})`;
      console.log(name);
    });

  }


  // #addMarkersToMap() {
  //   this.markersValue.forEach((marker) => {
  //     const popup = new mapboxgl.Popup().setHTML(marker.info_window)
  //     new mapboxgl.Marker()
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .setPopup(popup)
  //       .addTo(this.map)
  //   })
  // }

  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  // }
}
