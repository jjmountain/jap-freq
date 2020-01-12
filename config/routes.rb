Rails.application.routes.draw do
  resources :imported_texts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'tokenize/:id', to: 'imported_texts#tokenize_text', as: :tokenize
  root to: 'imported_texts#new'
end
