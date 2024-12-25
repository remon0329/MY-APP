Rails.application.routes.draw do
  get "sureddos/new"
  get "posts/index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  root "posts#top"
  get "posts/sureddo", to: "posts#sureddo", as: "sureddo_posts"
  resources :sureddos, only: [ :index, :create, :new, :show ] do
    resources :comments, only: [ :create ], controller: "comments", action: "create_for_sureddo"
  end

  resources :posts, only: [ :index, :new, :create, :show ] do
    member do
      get :detail
    end
    resources :comments, only: [ :create ], controller: "comments", action: "create_for_sureddo"
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
