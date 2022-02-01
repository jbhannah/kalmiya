import { Controller } from "../lib/controller";

// Connects to data-controller="reset-form"
export default class extends Controller<HTMLFormElement> {
  reset() {
    this.element.reset();
  }
}
