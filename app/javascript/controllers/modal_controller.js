import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    if (!document.cookie.includes("modal_shown=true")) {
      this.modalTarget.classList.remove("hidden")
    }
  }

  close() {
    this.modalTarget.classList.add("hidden")
    document.cookie = "modal_shown=true; path=/; max-age=31536000" // 1年保持
  }
}
