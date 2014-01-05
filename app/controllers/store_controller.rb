class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    @time = Time.now().strftime("%c")
    increase_session_index_access_counter
  end
  
  private
  def increase_session_index_access_counter
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1 
    end
  end
end
