Rails.application.routes.draw do
  get "posts/index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "posts#top"
  resources :posts, only: [:index, :new, :create]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
