class Admin::ItemsController < ApplicationController
    has_one_attached :image
    before_action :authenticate_admin!, only: [:create,:edit,:update,:index, :show, :new]
    
    def show
        @item=Item.find(params[:id])
    end
    
    def index
        @items=Item.page(params[:page])
    end
    

    def new
        @items=Item.new
    end
    
    def create
        @item = Item.new(item_params)
        @item.customer_id = current_customer.id
        if @item.save
            redirect_to admins_items_path(@item)
        else
            redirect_to new_admins_item_path
        end
    end

    def edit
        @item=Item.find(params[:id])
    end
    
    def update
        @item=Item.find(params[:id])
        if @item.update(item_params)
            redirect_to admins_items_path(@item)
            flash[:notice_update]="商品情報を更新しました"
        else
            redirect_to edit_admins_items_path(@item)
        end
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name, :introduction, :price, :image, :is_active)  
    end
　
end
