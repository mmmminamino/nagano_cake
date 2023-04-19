class Public::CustomersController < ApplicationController
end

def new
end

def show
    @customer=current_customer
end

def edit
    @customer=current_customer
end

