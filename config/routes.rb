Rails.application.routes.draw do
  get "sureddos/new"
  get "posts/index"
  get "privacy-policy", to: "pages#privacy_policy"
  get "images/ogp.png", to: "images#ogp", as: "images_ogp"
  get "/manifest.json", to: "application#manifest"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  root "posts#top"
  get "posts/sureddo", to: "posts#sureddo", as: "sureddo_posts"
  get "sureddos/search", to: "sureddos#search", as: "sureddo_search"
  resources :sureddos, only: [ :index, :create, :new, :show, :edit, :update, :destroy ] do
    collection do
      get :search
    end
    resource :like, only: [ :create, :destroy ]
    resources :comments, only: [ :create ], controller: "comments", action: "create_for_sureddo"
  end

  resources :posts, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    member do
      get :detail
    end
    collection do
      get :like_show
      get :search
    end
    resource :like, only: [ :create, :destroy ]
    resources :comments, only: [ :create ], controller: "comments", action: "create_for_post"
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
