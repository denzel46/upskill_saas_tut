Rails.application.routes.draw do
  devise_for :users
     root to: "pages#home"
     get 'about', to: 'pages#about'
     resources :contacts, only: :create
     #route /contacts/new to /contact-us
     get 'contact-us', to: 'contacts#new', as: 'new_contact'
     #get 'signup', to: 'devise/registrations#new', as:'new_user_registration'
end
