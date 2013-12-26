require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "Add Items to the cart" do
    cart = Cart.new
    cart.save!
    first_addition = cart.add_product(products(:ruby).id)
    first_addition.save!
    assert_equal 1, cart.line_items.length
    assert_equal 1, cart.line_items[0].quantity
    assert_equal 49.50, cart.total_price
    
    second_addition = cart.add_product(products(:ruby).id)
    second_addition.save!
    assert_equal 1, cart.line_items(true).length
    assert_equal 2, cart.line_items[0].quantity
    assert_equal 99.0, cart.total_price
    
    third_addition = cart.add_product(products(:ruby2).id)
    third_addition.save!
    assert_equal 2, cart.line_items(true).length
    assert_equal 1, cart.line_items[1].quantity
    assert_equal 149.0, cart.total_price
    
    
    
    #cart.add_product(products(:ruby2).id).save!
    #assert_equal 2, cart.line_items.length
    
    
    #puts "result is#{cart.line_items.find_by(products(:ruby).id)}"
    #puts cart.line_items[1].quantity
    #puts cart.line_items[2].quantity
    #puts cart.line_items[3].product.id
    #assert_equal 2, cart.line_items.length
    #assert_equal cart.total_price,  149
        
  end
end
