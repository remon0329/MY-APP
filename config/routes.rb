Rails.application.routes.draw do
  get "posts/index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root 'static_pages#top'
  resources :posts, only: [:index]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :posts
end
