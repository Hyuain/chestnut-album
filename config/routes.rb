Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match '/sing_in', to: 'sessions#create', via: [:get, :post]
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/test', to: 'sessions#test'
  get '/pre_oss_info', to: 'photos#get_pre_oss_info'
  resources :photos
end
