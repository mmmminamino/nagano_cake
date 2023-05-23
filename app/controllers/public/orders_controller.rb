class Public::OrdersController < ApplicationController
    before_action :authenticate_customer!
    
    def about #注文情報入力
      @order=Order.new
      @customer=current_customer
      @addresses=Address.where(customer_id: current_customer.id)
    end
    
    def address_display
      '〒' + postal_code + ' ' + address + ' ' + name
    end
    
    def create
        customer=current_customer
        session[:order]=Order.new
        cart_items=current_customer.cart_items
        @customer.id = current_customer.id
        @customers= Customer.all
        if @customer.save
          redirect_to customer_path
        else
          render :new
        end
    end
    
    def new
      @cart_items=current_customer.cart_items
    end
    
    def thanks #サンクスページ
      order=Order.new(session[:order])
      order.save
      if session[:new_address]
        shipping_address=current_customer.shipping_addresses.new
        shipping_address.postal_code=order.postal_code
        shipping_address.address=order.address
        shipping_address.name=order.name
        shipping_address.save
        session[:new_address]=nil
      end
      cart_items=current_customer.cart_items
      cart_items.each do |cart_item|
        order_item=OrderDetail.new
        order_item.order_id=order.id
        order_item.item_id=cart_item.item.id
        order_item.quantity=cart_item.quantity
        order_item.making_status=0
        order_item.price=(cart_item.item.price_without_tax * 1.1).floor
        order_item.save
      end
      
      cart_items.destroy_all　#購入後カート内削除
    end
    
    def index
      @orders=current_customer.orders
    end
    
    def show
      @order=Order.find(params[:id])
      @order_items=@order.order_items
    end
    
    def confirm
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    
    # def edit
    #   @customer=Customer.find(params[:id])
    # end
    
    
    # def update
    #     @customer=User.find(params[:id])
    #     @customer.update(customer_params)
    #     if @customer.update(customer_params)
    #       flash[:notice] ="You have updated user successfully."
    #       redirect_to customer_path(@customer.id)
    #     else
    #       render:edit
    #     end
    # end
    private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name)
    end
end
