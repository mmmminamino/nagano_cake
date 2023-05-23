class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!
    
    def index
        @cart_items=current_customer.cart_items
        @total_price=@cart_items.sum{|cart_item|cart_item.item.price * cart_item.amount}
        # @item=Item.find(params[:id])
    end
    
    def create
        # @item=Item.find(params[:id])
        @cart_item = CartItem.new(cart_item_params)
        # @cart_item=CartItem.new(item_id: (params[:cart_item][:item_id]), amount: params[:cart_item][:amount])
        @cart_item.customer_id=current_customer.id
        # @cart_item.item_id=params[:item_id]
        if @cart_item.save!
            flash[:notice]="#{@cart_item.item.name}をカートに追加しました"
            redirect_to public_cart_items_path
        else
            @item=Item.find(params[:cart_item][:item_id])
            flash[:alert]="個数を選択してください"
            render "public/items/show"
        end
    end
    
    def update
        @cart_item=CartItem.find(params[:id])
        @cart_item.update(cart_item_params)
        redirect_to public_cart_items_path
    end

    def destroy
        @cart_item=CartItem.find(params[:id])
        @cart_item.destroy
        flash.now[:alert]="#{@cart_item.item.name}を削除しました"
        redirect_to public_cart_items_path
    end
    
    def all_destroy
        @cart_item=current_customer.cart_items
        @cart_item.destroy_all
        flash[:alert]="カート内の商品をすべて削除しました"
        redirect_to public_cart_items_path
    end
    
    private
    
     def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount)
     end

end