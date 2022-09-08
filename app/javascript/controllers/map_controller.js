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

  test(e) {
    if(e.target.innerHTML !== 'undefined') {
      const laneNames = []
      const directionText = e.target.innerText
      const regex = /onto\s(.+)\b/g;

      const lanes = directionText.matchAll(regex);

      for (const lane of lanes) {
        laneNames.push(lane[1]);
      }

      const result = [...new Set(laneNames)]
      console.log(result);

      const url = `/?query=${result.join(",")}`
      fetch(url, {headers: {"Accept": "text/plain"}})
        .then(response => response.text())
        .then((data) => {
          this.buttonTarget.insertAdjacentHTML("afterbegin", data)
          console.log(data)
        })
      this.exitTarget.classList.toggle("d-none")
    }
    // laneNames.forEach((lane) => console.log(lane))
    // const startingLocation = document.querySelectorAll("input")[0]
    // const endingLocation = document.querySelectorAll("input")[1]

    // console.log(startingLocation.value);
    // console.log(endingLocation.value);

    // this.fetchCoordinates(startingLocation.value)
    // this.fetchCoordinates(endingLocation.value)

    // console.log(coordinate2);
  }

  async fetchCoordinates(query) {

    const response = await fetch(`https://api.mapbox.com/geocoding/v5/mapbox.places/${query}.json?country=ca&limit=1&access_token=${this.apiKeyValue}`);

    const data = await response.json()
    return data["features"][0]["center"]
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
    // console.log(e.target.dataset.showMarkers == 'true');
    // this.map._markers.forEach( marker => marker.remove() )
    if(currentMarkers.length > 0) {
      currentMarkers.forEach (marker => marker.remove())
      currentMarkers = []
    } else {
      this.addMarkersToMap()
    }
  }

    loadRoutes(e) {

    //   e.target.addSource('route', {
    //   'type': 'geojson',
    //   'data': {
    //     'type': 'Feature',
    //     'properties': {},
    //     'geometry': {
    //     'type': 'LineString',
    //     'coordinates': this.lanesCoordinatesValue
    //   }
    // }
    // });

      e.target.addSource('full', {
        'type': 'geojson',
        'data': 'https://lionheartsg.github.io/data/test2.geojson'
      });

      // e.target.addLayer({
      //   'id': 'route',
      //   'type': 'line',
      //   'source': 'route',
      //   'layout': {
      //   'line-join': 'round',
      //   'line-cap': 'round'
      // },
      //   'paint': {
      //   'line-color': '#ff0000',
      //   'line-width': 8
      //   }

      // });

      e.target.addLayer({
        'id': 'full',
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

    e.target.on('click', 'full', (e) => {
      const objectID = e.features[0].properties.OBJECTID
      // update()
      // console.log(objectID);

      const url = `/lanes/${objectID}`
      fetch(url, {headers: {"Accept": "text/plain"}})
        .then(response => response.text())
        .then((data) => {
          this.lanepartialTarget.innerHTML = data
        })


      // const coordinates = e.features[0].geometry.coordinates;
      // console.log(coordinates);
      // const type = e.features[0].properties.INFRA_HIGHORDER;
      // console.log(type);
      // const name = `${e.features[0].properties.STREET_NAME} (${e.features[0].properties.FROM_STREET} - ${e.features[0].properties.TO_STREET})`;
      // console.log(name);
    });

  }



  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  // }
}
