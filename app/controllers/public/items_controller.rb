class Public::ItemsController < ApplicationController
end

def new
    @item=Item.new
end

def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    @item.save
    redirect_to items_path
end

def index
end

def show
end

def edit
end

