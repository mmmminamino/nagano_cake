class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @search=Order.ransack(params[:q])
        @orders=@search.result.page(params[:page]).per(20)
    end
    
    def show
        @order=Order.find(params[:id])
        @order_items=@order.order_items
    end
    
    def update
        order=Order.find(params[:id])
        order_items=order.order_items
        order.update(order_params)
            if order.order_status=="入金確認"
                order_items.update_all(making_status: "製作中")
            end
            redirect_to admins_order_path(order.id)
    end
    
    private
        def order_params
            params.require(:order).permit(:order_status)
        end
end
