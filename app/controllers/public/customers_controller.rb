class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
    # def new
    #   @customer=Customer.new
    # end
    
    # def create
    #   @customer = Customer.new(customer_params)
    #   @customer.id = current_customer.id
    #   @customers= Customer.all
    #   if @customer.save
    #     redirect_to customer_path
    #   else
    #     render :new
    #   end
    # end   
    
    def show
      @customer=current_customer
    end
    
    def edit
      @customer=current_customer
    end
    
    def update
      @customer=current_customer
      if @customer.update(customer_params)
        flash[:success] ="登録情報を変更しました"
        redirect_to customer_path(@customer.id)
      else
        render:edit
      end
    end
    
    def quit
    end
    
    def withdraw
      @customer=current_customer
      @customer.update(is_deleted: true)
      reset_session
      flash[:notice] ="ご利用ありがろうございました。またのご利用をお待ちしております。"
      redirect_to root_path
    end
      
  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
    end
end
