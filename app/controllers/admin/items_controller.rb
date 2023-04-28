class Admin::ItemsController < ApplicationController

    def new
        @item=Item.new
    end
    
    def create
        @item = Item.new(item_params)
        @item.customer_id = current_customer.id
        @item.save
        redirect_to items_path
    end
    
    def index
        Item.page(params[:page])
    end
    
    def show
        @item=Item.find(params[:id])
    end
    
    def edit
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name, :introduction, :price, :image)  
    end
　
end
