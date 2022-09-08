import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["slider-toggle", "wrap", "toggles"]

  connect() {
    console.log("connected slider controller")
  }

  slideToggle() {
    this.wrapTarget.classList.toggle("active")

    if(this.wrapTarget.classList.contains("active")) {
      this.wrapTarget.style.overflow = "hidden"
      this.togglesTarget.style.display = "none"
    } else {
      this.wrapTarget.style.overflow = "visible"
      this.togglesTarget.style.display = "block"
    }
  }

}
