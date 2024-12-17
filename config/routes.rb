Rails.application.routes.draw do
  get "posts/index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  root "posts#top"
  get "posts/sureddo", to: "posts#sureddo", as: "sureddo_posts"
  resources :posts, only: [ :index, :new, :create, :show, :sureddo ]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
