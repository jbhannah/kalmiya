import { Controller as _Controller } from "@hotwired/stimulus";

export class Controller<T extends HTMLElement> extends _Controller {
  private _element: T;

  get element(): T {
    return this._element;
  }
}
