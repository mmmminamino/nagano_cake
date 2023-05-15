Rails.application.routes.draw do
 
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  root to: 'homes#top'
  get 'about' => 'homes#about', as: 'about'
  # get '/admin', to: 'admin#top'
  # resources :admins
  # resources :items, only: [:index, :destroy, :edit, :show, :edit]
  # resources :customers, only: [:index, :show, :edit, :update]
  
  #devise_for :public_items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #devise_for :admin_items
  
  # root to: "homes#top"
  # get '/about'=>'homes#about', as:'about'
  # get '/customers/:id', to: 'customers#show'
  # get '/customers/information/edit', to: 'customers#edit'
  # patch '/customers/information', to: 'customers#update'
  # get 'edit/:id' => 'public/customers#edit'
  
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:index, :destroy, :edit, :show, :edit]
    resources :genres, only: [:index, :create, :edit, :update]
  end
  
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'
    resource :customers, only: [:show, :edit, :update]
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm_order'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks_order'
  end
end

