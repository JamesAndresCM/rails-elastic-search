Rails.application.routes.draw do
  get "search", to: "search#search"
  root to: 'articles#index'
  resources :articles
end
