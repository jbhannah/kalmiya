import { Context, Controller as _Controller } from "@hotwired/stimulus";

export class Controller<T extends HTMLElement> extends _Controller {
  context: Context & {
    scope: Context["scope"] & {
      element: T;
    };
  };
}
