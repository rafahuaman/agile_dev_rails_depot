require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 4
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
    assert_select '#time', 1
  end
  
  test "should increment access counter" do 
    20.times do
      if session[:counter].nil?
        get :index
        assert session[:counter] == 1, "Does not initalize to 1"
      else
        assert_difference('session[:counter]', 1, "Session counter should change by 1 when index is accessed") do
          get :index
        end
      end
              
      if session[:counter] <=5 
        assert_select '#access_times', false
      else
        assert_select '#access_times', "Storefront accessed #{session[:counter]} times."
      end
    end
  end

end
   