import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("checkobox controller")
  }

  submit() {
    this.element.closest("form").requestSubmit();
  }
}
