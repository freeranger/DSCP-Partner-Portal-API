Rails.application.routes.draw do
  post 'login', to: 'user_token#create'
  resources :contacts

  resources :groups do
    #resources :contacts
    resources :links
    #resources :notes
  end

  get :partners, :controller => 'contacts', :action => 'partners', :as => 'partners'
end
