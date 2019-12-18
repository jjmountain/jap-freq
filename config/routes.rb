Rails.application.routes.draw do
  resources :imported_texts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'imported_texts#new'
end
