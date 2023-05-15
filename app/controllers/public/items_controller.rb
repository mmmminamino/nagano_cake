class Public::ItemsController < ApplicationController
    has_one_attached :image
    # def new
    #     @item=Item.new
    # end
    
    # def create
    #     @item = Item.new(item_params)
    #     @item.customer_id = current_customer.id
    #     @item.save
    #     redirect_to items_path
    # end
    
    def index
        @items = Item.all
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