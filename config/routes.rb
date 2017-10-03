Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'audiobooks#show'

  get 'audiobooks', to: 'audiobooks#show', as: :content_root
  get 'audiobooks/*path', to: 'audiobooks#show', as: :content, constraints: { path: /.*/ }
  get 'stream/*path', to: 'audiobooks#stream', as: :stream, constraints: { path: /.*/ }
end
