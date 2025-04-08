// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Rails from "@rails/ujs";
Rails.start();

document.addEventListener('turbo:load', function () {
  const dropdownButton = document.getElementById('dropdownMenuButton');
  if (dropdownButton) {
    const dropdownMenu = document.getElementById('dropdownMenu');
    dropdownButton.addEventListener('click', function () {
      dropdownMenu.classList.toggle('hidden');
    });

    // ドロップダウン外をクリックした場合にメニューを閉じる
    document.addEventListener('click', function (e) {
      // ドロップダウンボタン外をクリックした場合にメニューを閉じる
      if (!dropdownButton.contains(e.target) && !dropdownMenu.contains(e.target)) {
        dropdownMenu.classList.add('hidden');
      }
    });
  }
});

document.addEventListener("DOMContentLoaded", function() {
    const openModalButton = document.getElementById("openModalButton");
    const closeModalButton = document.getElementById("closeModalButton");
    const modal = document.getElementById("modal");

    openModalButton.addEventListener("click", function() {
      modal.classList.remove("hidden");
    });

    closeModalButton.addEventListener("click", function() {
      modal.classList.add("hidden");
    });

    window.addEventListener("click", function(event) {
      if (event.target === modal) {
        modal.classList.add("hidden");
      }
    });
  });