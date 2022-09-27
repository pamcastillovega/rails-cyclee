import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["wrap", "slide"]

  connect() {
    console.log("connected slider controller")
  }

  slideToggle() {
    this.wrapTarget.classList.toggle("active")

    // this.wrapTarget.style.height = "0px"

    // this.wrapTarget.classList.toggle("active")
    // this.closeTarget.style.display = "block"

    // if(this.wrapTarget.classList.contains("active")) {
    //   this.slideTarget.style.display = "none"
    // }

    // if(this.wrapTarget.classList.contains("active")) {
    //   this.wrapTarget.style.overflow = "hidden"
    //   this.wrapTarget.style.overflow = "scroll"
    // } else {
    //   this.wrapTarget.style.overflow = "visible"
    // }
  }
}
