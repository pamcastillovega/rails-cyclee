import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-submit"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("init");
  }

  send(e) {
    e.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "text/plain", },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.formTarget.outerHTML = data
      })
  }
}
