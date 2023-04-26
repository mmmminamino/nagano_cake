Rails.application.routes.draw do
 
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "homes#top"
  get '/about'=>'homes#about', as:'about'
  resources :customers, only: [:new, :create, :index, :show, :edit]
  resources :items, only: [:new, :create, :index, :show, :edit]
end
