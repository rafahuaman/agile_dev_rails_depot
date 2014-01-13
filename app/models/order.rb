class Order < ActiveRecord::Base
  include ActiveModel::Dirty
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type
  validates :name, :address, :email, :pay_type_id, presence: true
  after_save :send_notifiation_after_shipped_date_update 
  
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  private
  def send_notifiation_after_shipped_date_update
    OrderNotifier.shipped(self).deliver if self.ship_date_changed?     
  end
end
