require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  def setup
  end
  
  fixtures :products
   test "buying a product" do
     LineItem.delete_all
     Order.delete_all
     ruby_book = products(:ruby)
      
     get "/"
     assert_response :success
     assert_template "index"
      
     xml_http_request :post, '/line_items', product_id: ruby_book.id
     assert_response :success
      
     cart = Cart.find(session[:cart_id])
     assert_equal 1, cart.line_items.size
     assert_equal ruby_book, cart.line_items[0].product
      
     get "/orders/new"
     assert_response :success
     assert_template "new"
     order_pay_type_id = PayType.find_by( name: 'Check').id
     post_via_redirect "orders", order: {  name: "Dave Thomas",
                                           address: "123 The Street",
                                           email: "dave@example.com",
                                           pay_type_id: order_pay_type_id }
     assert_response :success
     assert_template "index"
      
     cart = Cart.find(session[:cart_id])
     assert_equal 0, cart.line_items.size, "Cart did not empty "
        
     orders = Order.all
     assert_equal 1, orders.size
     order = orders[0]
      
     assert_equal "Dave Thomas", order.name
     assert_equal "123 The Street", order.address
     assert_equal "dave@example.com", order.email
     assert_equal "Check", PayType.find(order.pay_type_id).name
     
     
     
     assert_equal 1, order.line_items.size
     line_item = order.line_items[0]
     assert_equal ruby_book, line_item.product
      
     mail = ActionMailer::Base.deliveries.last
     assert_equal ["dave@example.com"], mail.to
     assert_equal 'depot@example.com', mail[:from].value
     assert_equal "Pragmatic Store Order Confirmation", mail.subject
     
     order.update_attribute(:ship_date, Date.today)
     mail = ActionMailer::Base.deliveries.last
     assert_equal "Pragmatic Store Order Shipped", mail.subject
   end
  
  test "receiving an email after an attempt to access an invalid cart" do
    dave = users(:one)
    post login_path, name: dave.name, password: 'secret'
    get_via_redirect "/carts/wibble"
    assert_template "index"
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["leafar.huaman@gmail.com"], mail.to
    assert_equal 'depot@example.com', mail[:from].value
    assert_equal "Invalid Cart Access Attempt", mail.subject
    logout 
  end
end
