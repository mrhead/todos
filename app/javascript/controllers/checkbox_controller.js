import { Controller } from "stimulus"
import { navigator } from "@hotwired/turbo"

export default class extends Controller {
  submit() {
    navigator.submitForm(this.element.closest("form"))
  }
}
