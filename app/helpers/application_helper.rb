module ApplicationHelper
  def default_meta_tags
    {
      site: "GAMES_ MEMORY",
      title: "GAMES_ MEMORY",
      reverse: true,
      charset: "utf-8",
      description: "思い出深いゲームやハマったゲーム動画を埋め込んだり、スレッドを投稿してもらい
      色々な世代の人気なゲームからマイナーなゲームまで気軽に共有できるサービスです。",
      canonical: request.original_url,
      separator: "|",
      og: {
          site_name: "GAMES_ MEMORY",
          title: "GAMES_ MEMORY",
        description: "思い出深いゲームやハマったゲーム動画を埋め込んだり、スレッドを投稿してもらい
        色々な世代の人気なゲームからマイナーなゲームまで気軽に共有できるサービスです。",
        type: "website",
        url: request.original_url,
        image: image_url("OGP.png"),
        local: "ja-JP"
      },

      twitter: {
        card: "summary_large_image",
        site: "@https://x.com/remon_tanosimu",
        image: image_url("OGP.png")
      }
    }
  end
end
