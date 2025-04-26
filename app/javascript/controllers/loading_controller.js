import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["infinity"]

  connect() {
    this.hide()
  }

  show() {
    this.infinityTarget.classList.remove("hidden")
  }

  hide() {
    this.infinityTarget.classList.add("hidden")
  }
}
