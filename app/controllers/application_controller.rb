class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def manifest
    render json: {
      name: "GAMES_MEMORY",
      short_name: "GAMES_MEMORY",
      start_url: "/",
      display: "standalone",
      background_color: "#ffffff",
      theme_color: "#000000",
      description: "思い出深いゲームやハマったゲーム動画を共有するサービス",
      icons: [
        {
          src: "/icon.png",
          sizes: "192x192",
          type: "image/png"
        },
        {
          src: "/icon.svg",
          sizes: "any",
          type: "image/svg+xml"
        }
      ]
    }
  end
end
