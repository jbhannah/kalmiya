import { Application } from "@hotwired/stimulus";

declare global {
  interface Window {
    Stimulus: Application;
  }
}

const application = Application.start();

// Configure Stimulus development experience
application.debug = true;
window.Stimulus = application;

export { application };
