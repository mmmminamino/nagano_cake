Rails.application.routes.draw do
 
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_scope :customer do
    post '/customers/sign_up', to: 'public/registrations#create', as: 'custom_registration'
  end
    


  root to: "public/items#top"

  scope module: 'customers' do
    resources :items, only: [:show, :index]
    get 'about' => 'items#about'
   end
  

namespace :public do
    # resources :genres, only: [:show]
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'#退会
    get '/my_page', to: 'customers#show', as: 'my_page'#マイページ
    resources :my_page, only: [:show]
    get 'customers/edit' => 'customers#edit'
    patch 'update' => 'customers#update'
    get 'quit' => 'customers#quit'#退会画面
    get 'orders/about' => 'orders#about', as: 'orders_about'#注文情報入力
    # post 'orders/confirm' => 'orders#new', as: 'confirm_order'#注文情報確認
    get 'orders/thanks' => 'orders#thanks', as: 'thanks_order'#サンクス
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show]#注文情報確認、注文履歴一覧、注文履歴詳細
    resources :cart_items, only: [:index, :create, :update, :destroy]
    # resources :customers, only: [:new, :create, :edit, :update]
    delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
  end

  # root to: 'homes#top'
  # get 'about' => 'homes#about', as: 'about'
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
  
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  namespace :admin do
    root :to => 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
    delete 'items'=> 'items#destroy'
  end
end