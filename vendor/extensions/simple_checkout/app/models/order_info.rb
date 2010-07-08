class OrderInfo < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id, :name, :surname, :street, :city, :zip, :country, :phone
end
