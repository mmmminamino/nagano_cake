class CustomersController < ApplicationController
    def new
      @customer=Customer.new
    end
    
  　def create
      @customer = Customer.new(customer_params)
      @customer.id = current_customer.id
      @customers= Customer.all
      if @customer.save
        redirect_to customer_path
      else
        render :new
      end
  　end
  　
    def show
      @customer=Customer.find(params[:id])
    end
    
    def edit
      @customer=Customer.find(params[:id])
    end
    
    def update
      @customer=User.find(params[:id])
      @customer.update(customer_params)
      if @customer.update(customer_params)
        flash[:notice] ="You have updated user successfully."
        redirect_to customer_path(@customer.id)
      else
        render:edit
      end
    end
    
  private
    def customer_params
      params.require(:customer)
    end
end
