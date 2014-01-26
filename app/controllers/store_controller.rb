class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
      @time = Time.now().strftime("%c")
      increase_session_index_access_counter
    end
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
