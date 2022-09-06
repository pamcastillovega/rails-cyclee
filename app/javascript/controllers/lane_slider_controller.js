import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lane-slider"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log("connected lane slider controller")
  }

  slide() {
  }

  // when click, pointer-events: none?
}
