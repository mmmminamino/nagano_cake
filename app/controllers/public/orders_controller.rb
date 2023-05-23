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
        # customer=current_customer
        session[:order]=Order.new
        cart_items=current_customer.cart_items
        # @customer.id = current_customer.id
        @customers= Customer.all
        @customer=current_customer
        sum = 0
        cart_items.each do |cart_item|
        sum += (cart_item.item.price * 1.1).floor * cart_item.amount
        end
        session[:order][:postage] = 800
        session[:order][:billing_amount] = sum + session[:order][:postage]
        session[:order][:order_status] = 0
        session[:order][:customer_id] = @customer.id
        # ラジオボタンで選択された支払方法のenum番号を渡している
        session[:order][:payment_methods] = params[:method].to_i
        
        destination = params[:a_method].to_i
        if destination == 0
          session[:order][:postal_code] = @customer.postal_code
          session[:order][:address] = @customer.address
          session[:order][:name] = @customer.last_name + @customer.first_name
        elsif destination == 1
          address = Address.find(params[:address_for_order])
          session[:order][:postal_code] = address.postal_code
          session[:order][:address] = address.address
          session[:order][:name] = address.name
        elsif destination == 2
          session[:new_address] = 2
          session[:order][:postal_code] = params[:postal_code]
          session[:order][:address] = params[:address]
          session[:order][:name] = params[:name]
        end
        if session[:order][:postal_code].presence && session[:order][:address].presence && session[:order][:name].presence
          redirect_to new_public_order_path
        else
          redirect_to public_orders_about_path
        end
        # if @customer.save!
        #   redirect_to public_order_path
        # else
        #   render :about
        # end
    end
    
    def new
      @cart_items=current_customer.cart_items
    end
    
    def thanks #サンクスページ
      order=Order.new(session[:order])
      order.save
      if session[:new_address]
        address=current_customer.addresses.new
        address.postal_code=order.postal_code
        address.address=order.address
        address.name=order.name
        address.save
        session[:new_address]=nil
      end
      cart_items=current_customer.cart_items
      cart_items.each do |cart_item|
        order_item=OrderItem.new
        order_item.order_id=order.id
        order_item.item_id=cart_item.item.id
        order_item.quantity=cart_item.amount
        order_item.making_status=0
        order_item.price=(cart_item.item.price * 1.1).floor
        order_item.save
      end
      
      #購入後カート内削除
      current_customer.cart_items.destroy_all
      # render "thanks"
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
