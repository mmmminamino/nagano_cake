class Public::ItemsController < ApplicationController
    
    def top
        @genres=Genre.all
        @items = Item.all
    end
 
    def index
        @items=Item.page(params[:page])
        @items_all = Item.all
    end
    
    def show
        @item=Item.find(params[:id])
        @cart_item=CartItem.new
    end
    
    def about
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name, :introduction, :price, :image)  
    end
end