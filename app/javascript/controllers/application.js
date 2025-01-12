import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

$(document).ready(function() {
    // 検索入力フィールド
  $('input[name="query"]').autocomplete({
    source: function(request, response) {
      $.ajax({
        url: '/posts/search',  // 検索用のURL
        dataType: 'json',
        data: {
          term: request.term  // 入力されたクエリ
        },
        success: function(data) {
          response(data);
        }
      });
    },
    minLength: 2,  // 2文字以上入力でオートコンプリートを表示
  });
});
