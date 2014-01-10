class PayType < ActiveRecord::Base
  has_many :orders
  
  def self.names
    PayType.all.collect { |paytype| paytype.name }
  end
end
