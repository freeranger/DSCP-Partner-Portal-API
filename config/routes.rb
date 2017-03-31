Rails.application.routes.draw do
  post 'login', to: 'user_token#create'
  resources :contacts
  get :partners, :controller => 'contacts', :action => 'partners', :as => 'partners'
end
