class Public::CustomersController < ApplicationController
end

def new
end

def create
    @customer = Customer.new(customer_params)
    @customer.user_id = current_user.id
    @customers= Customer.all
    if @customer.save
      redirect_to customers_path
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

