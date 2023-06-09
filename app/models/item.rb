class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  #attr_accessor :authenticity_token
  has_one_attached :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}
  
  #消費税
  def with_tax_price
    (price * 1.1).floor
  end
end
