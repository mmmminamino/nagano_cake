class Admin::ItemsController < ApplicationController
    #has_one_attached :image
    before_action :authenticate_admin!, only: [:create,:edit,:update,:index, :show, :new]
    
    def show
        @item=Item.find(params[:id])
        @cart_item = CartItem.new
        # @genres=Genre.all
    end
    
    def index
        @search=Item.ransack(params[:q])
        @items=@search.result.page(params[:page]).per(10)
    end
    

    def new
        @items=Item.new
        # @genre=[["ケーキ"], ["焼き菓子"], ["プリン"]]
        # @genres=Genre.all
        @active=[["販売中","false"], ["販売停止中","true"]]
    end
    
    def create
        @item = Item.new(item_params)
        #@item.customer_id = current_customer.id
        if @item.save!
            redirect_to admin_item_path(@item)
        else
            redirect_to new_admin_item_path
        end
    end

    def edit
        @item=Item.find(params[:id])
        @active=[["販売中","false"], ["販売停止中","true"]]
    end
    
    def update
        @item=Item.find(params[:id])
        if @item.update(item_params)
            redirect_to admin_items_path(@item)
            flash[:notice_update]="商品情報を更新しました"
        else
            redirect_to edit_admin_items_path(@item)
        end
    end
    
    def destroy
        @item=Item.find(params[:id])
        @item.destroy
        flash.now[:alert]="#{@item.name}を削除しました"
        redirect_to admin_items_path
    end
    
private
    def item_params
        params.require(:item).permit(:name, :introduction, :price, :image, :is_active)  
    end
end
