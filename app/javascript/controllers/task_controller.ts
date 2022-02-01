import { Controller } from "../lib/controller";
import { headers } from "../lib/fetch";

// Connects to data-controller="task"
export default class extends Controller<HTMLElement> {
  async completed() {
    this.#checkbox().disabled = true;

    await fetch(`/tasks/${this.#taskID()}`, {
      method: "PATCH",
      headers,
      body: JSON.stringify({
        task: {
          completed: this.#checkbox().checked,
        },
      }),
    });

    this.#checkbox().disabled = false;
  }

  #checkbox() {
    return this.element.querySelector<HTMLInputElement>("input[type=checkbox]");
  }

  #taskID() {
    return this.element.dataset.taskId;
  }
}
