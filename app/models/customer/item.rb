class Customer::Item < ApplicationRecord
  self.table_name = 'customer_items'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
         
  has_one_attached :image, dependent: :destroys
end
