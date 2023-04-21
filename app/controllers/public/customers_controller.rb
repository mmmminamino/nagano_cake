class Public::CustomersController < ApplicationController
end

def new
end

def create
    @customer = Customer.new(customer_params)
    @customer.id = current_user.id
    if @customer.save
      redirect_to customers_path
    else
      render :new
    end
end

def show
    @customer=current_customer
end

def edit
    @customer=current_customer
end

