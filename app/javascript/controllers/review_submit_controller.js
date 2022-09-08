import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-submit"
export default class extends Controller {
  static targets = ["form", "header"]

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
        console.log(data)
        this.formTarget.outerHTML = data

        if(data.includes("Submitted")) {
          this.headerTarget.innerHTML = `${this.headerTarget.innerHTML} <i class="fa-solid fa-circle-check"></i>`
          this.headerTarget.classList.remove("form-error")
          this.headerTarget.classList.add("submitted")
        } else {
          this.headerTarget.classList.add("form-error")
        }
      })
  }
}
