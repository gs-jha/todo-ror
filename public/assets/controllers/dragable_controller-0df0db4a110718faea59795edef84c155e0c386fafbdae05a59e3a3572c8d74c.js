import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      group: {
        name: "group",
        pull: "clone",
        put: "append",
      },
      animation: 150,
      ghostClass: "sortable-ghost",
      draggableClass: "sortable-draggable",
      onEnd: this.onEnd.bind(this),
    });
  }

  onEnd(event) {
    console.log(event);
    let id = event.item.dataset.id;
    let data = new FormData();
    data.append("position", event.newIndex + 1);

    Rails.ajax({
      url: this.data.get("url").replace(":id", id),
      type: "PATCH",
      data: data,
    });
  }
};
