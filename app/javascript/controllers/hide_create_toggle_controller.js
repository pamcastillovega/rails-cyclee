import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-create-toggle"
export default class extends Controller {
  static targets = ['parking', 'create']

  connect() {
    console.log("hide create toggle controller conntected")
  }

  hide() {
    this.createTarget.classList.toggle("d-none")
  }
}
