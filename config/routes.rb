Rails.application.routes.draw do
 
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  get '/admin', to: 'admin#top'
  resources :admins, only: [:top]
  #devise_for :public_items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #devise_for :admin_items
  
  root to: "homes#top"
  get '/about'=>'homes#about', as:'about'
  get '/customers/:id', to: 'customers#show'
  get '/customers/information/edit', to: 'customers#edit'
  patch '/customers/information', to: 'customers#update'
  resources :customers, only: [:new, :create, :index, :show, :edit]
  resources :items, only: [:new, :create, :index, :show, :edit]
  
  get 'edit/:id' => 'public/customers#edit'
  namespace :admin do
    resources :admin_items, only: [:new, :create, :index, :show, :edit]
    get 'edit/:id' => 'admin/customers#edit'
  end
end
