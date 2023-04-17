Rails.application.routes.draw do
  root to: "homes#top"
  get '/about'=>'homes#about', as:'about'
  
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :admins, only: [:new, :create, :index, :show]
  resources :customers, only: [:new, :create, :index, :show]
  resources :items, only: [:new, :create, :index, :show]
end
