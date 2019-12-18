import { Controller } from "stimulus"

export default class extends Controller {
  // your logic (controller actions)
  connect() {
    console.log('Connected', this.element)
  }

  disconnect() {
    console.log('DISCONNECTED!')
  }
}