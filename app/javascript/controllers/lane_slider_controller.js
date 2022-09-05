import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lane-slider"
export default class extends Controller {
  static targets = ["bar"]

  connect() {
    console.log("connected lane slider controller")
  }

  slide() {
    console.log("click")
    // this.barTarget.style.top = 0;
  }
}
