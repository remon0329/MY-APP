Rails.application.routes.draw do
  root 'home#index'
  get 'health_checks/index'
end
