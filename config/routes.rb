Rails.application.routes.draw do
  post 'login', to: 'user_token#create'
  resources :contacts

  resources :groups do
    resources :links
    resources :notes
  end
  get    'groups/:id/contacts', :controller => 'groups', :action => 'list_group_contacts', :as => 'group_contacts'
  delete 'groups/:id/contacts/:contact_id', :controller => 'groups', :action => 'delete_group_contact', :as => 'group_contact_delete'
  put    'groups/:id/contacts/:contact_id', :controller => 'groups', :action => 'add_group_contact', :as => 'group_contact_add'

  get :partners, :controller => 'contacts', :action => 'partners', :as => 'partners'
end