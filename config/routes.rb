Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => 'xml#index'
  get '/awards/:id', to: 'awards#show', as: 'award'
  get '/filers/:id', to: 'filers#show', as: 'filer'
  get '/receivers/:id', to: 'receivers#show', as: 'receiver'
  
  resources :awards
  resources :receivers
  resources :filers

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
