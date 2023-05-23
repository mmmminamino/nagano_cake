class Public::ItemsController < ApplicationController
    before_action :authenticate_customer!, only: [:create,:index, :show, :new]
    
    def top
        # @genres=Genre.all
        @items = Item.all
    end
 
    def index
        @search=Item.ransack(params[:q])
        @items=@search.result.page(params[:page]).per(10)
        @items_all = Item.all
        # @genres=Genre.all
    end
    
    def show
        @item=Item.find(params[:id])
        @cart_item=CartItem.new
        # @genres=Genre.all
    end
    
    def 
    
    def about
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name, :introduction, :price, :image, :is_active)  
    end
end