import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    console.log(this.contentTarget)
  }

  show() {
    this.element.innerText = "Dufferin St"
    this.contentTarget.classList.remove("d-none")
  }

}
