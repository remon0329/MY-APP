import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"];

  search() {
    const query = this.inputTarget.value;

    if (query.length > 0) {
      // URLパラメータにqueryを追加してGETリクエスト
      fetch(`/posts/search?q[title_cont]=${query}`, { method: "GET" })
        .then(response => response.json())
        .then(data => {
          this.resultsTarget.innerHTML = "";  // 検索結果をリセット

          if (data.length > 0) {
            data.forEach(post => {
              const li = document.createElement("li");
              li.classList.add("list-group-item", "cursor-pointer");
              li.innerHTML = `<span>${post.title}</span>`;
              li.addEventListener("click", () => this.selectTitle(post.title));
              this.resultsTarget.appendChild(li);
            });
          } else {
            const li = document.createElement("li");
            li.classList.add("list-group-item");
            li.innerHTML = "検索結果が見つかりませんでした";
            this.resultsTarget.appendChild(li);
          }
        })
        .catch(error => {
          console.error("検索エラー:", error);
        });
    } else {
      this.resultsTarget.innerHTML = "";  // 入力が空の場合、検索結果を非表示
    }
  }

  selectTitle(title) {
    this.inputTarget.value = title;  // 入力欄に選択したタイトルを設定
    this.resultsTarget.innerHTML = "";  // 検索結果を非表示
  }
}
