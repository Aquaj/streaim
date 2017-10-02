Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'audiobooks#index'

  resources :audiobooks, only: [:show]

  get 'audiobooks/:audiobook_id/:chapter_id', to: 'audiobooks#stream', as: :stream
end
