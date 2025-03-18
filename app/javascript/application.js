// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Rails from "@rails/ujs";
Rails.start();

document.addEventListener('DOMContentLoaded', function () {
  const dropdownButton = document.getElementById('dropdownMenuButton');
  if (dropdownButton) {
    const dropdownMenu = document.getElementById('dropdownMenu');
    dropdownButton.addEventListener('click', function () {
    dropdownMenu.classList.toggle('hidden');
    });
  }
});