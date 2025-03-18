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