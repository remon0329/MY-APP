Rails.application.routes.draw do
  get "posts/index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
<<<<<<< HEAD
  root "static_pages#top"
=======
  root "static_pages#top"
  resources :posts, only: [:index]
>>>>>>> top
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :posts
end
