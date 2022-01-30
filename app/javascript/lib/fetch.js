const CSRF_TOKEN = document.querySelector("meta[name='csrf-token']").content;

export const headers = {
  "Content-Type": "application/json",
  "X-CSRF-Token": CSRF_TOKEN,
};
