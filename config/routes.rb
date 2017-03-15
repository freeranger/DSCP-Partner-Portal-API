Rails.application.routes.draw do
  post 'login', to: 'user_token#create'
  resources :contacts
end
