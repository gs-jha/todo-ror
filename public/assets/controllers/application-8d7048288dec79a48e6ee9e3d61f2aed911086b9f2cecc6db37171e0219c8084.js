import { Application } from "@hotwired/stimulus";
import Rails from "@rails/ujs";
import { Tabs } from "tailwindcss-stimulus-components";

const application = Application.start();

application.register("tabs", Tabs);

Rails.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
