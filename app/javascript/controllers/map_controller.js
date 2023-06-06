import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
let currentMarkers = []

export default class extends Controller {

  static targets = ['wrapper', 'lanepartial', 'button', 'exit']
  static values = {
    apiKey: String,
    markers: Array,
    lanesCoordinates: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.wrapperTarget,
      style: "mapbox://styles/mapbox/light-v10",
      center: [-79.41241607325394, 43.651070],
      zoom: 12
    })

    this.map.on('load', this.loadRoutes.bind(this))

    this.directions = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: 'metric',
      profile: 'mapbox/cycling',
      alternatives: false,
      interactive: false,
      controls: { instructions: true, profileSwitcher: false }
    });

    this.location = new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      trackUserLocation: true,
      showUserHeading: true
    })

    // this.#fitMapToMarkers()
    this.addMarkersToMap()
    this.map.addControl(this.directions, 'top-left')
    this.map.addControl(this.location, 'top-right')

    const instructions = this.map._controlContainer.querySelector(".directions-control-instructions")
    instructions.dataset.action = "DOMNodeInserted->map#test"
  }

  addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      if(marker.flagged == true) {
        customMarker.classList.add("marker-red");
      }

      let oneMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        // .setPopup(popup)
        .addTo(this.map)
      currentMarkers.push(oneMarker)
      oneMarker.getElement().addEventListener('click', () => {
        const url = `/parking_locations/${marker.id}/reports`
        fetch(url, {headers: {"Accept": "text/plain"}})
        .then(response => response.text())
        .then((data) => {
          this.lanepartialTarget.innerHTML = data
        })
      });
      // popup.on('open', (event) => {
      //   console.log(marker.id);
      // });
    })
  }

  toggle(e) {
    if(currentMarkers.length > 0) {
      currentMarkers.forEach (marker => marker.remove())
      currentMarkers = []
    } else {
      this.addMarkersToMap()
    }
  }

  loadRoutes(e) {
      e.target.addSource('full', {
        'type': 'geojson',
        'data': '/api/lanes.json'
      });

      e.target.addLayer({
        'id': 'lane',
        'type': 'line',
        'source': 'full',
        'layout': {
        'line-join': 'round',
        'line-cap': 'round'
      },
        'paint': {
        'line-color': ['get', 'color'],
        'line-width': 3
        }
      });

    e.target.on('click', 'lane', (e) => {
      const objectID = e.features[0].properties.objectid
      const url = `/lanes/${objectID}`
      fetch(url, {headers: {"Accept": "text/plain"}})
        .then(response => response.text())
        .then((data) => {
          this.lanepartialTarget.innerHTML = data
        })
    });
  }
}
