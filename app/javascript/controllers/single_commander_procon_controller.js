import { Controller } from "@hotwired/stimulus"
import React from "react";
import ReactDOM from "react-dom";
import { Procon, buttons } from "react-nintendo-switch-procon-renderer";
import $ from 'jquery'

// Connects to data-controller="single-commander-procon"
export default class extends Controller {
  connect() {
    const procon = React.createElement(Procon, {
      pressedButtons: [],
      handleButtonClick: this.handleButtonClick.bind(this)
    });
    ReactDOM.render(procon, this.element);
  }

  disconnect() {
    ReactDOM.unmountComponentAtNode(this.element);
  }

  handleButtonClick(button) {
    console.log(button);
    $(`[data-remote-single-command="${button}"]`)[0].click();
  }
}
