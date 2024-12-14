Rails.application.routes.draw do
  get "profiles/show"
  get "posts/index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  root "posts#top"
  resources :posts, only: [ :index, :new, :create, :show ]
  resources :profiles, only: [ :show ]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
