import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dots"]

  connect() {
    this.hide()
  }

  show() {
    this.dotsTarget.classList.remove("hidden")
  }

  hide() {
    this.dotsTarget.classList.add("hidden")
  }
}
