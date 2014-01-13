require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  test "invalid_cart_requested" do
    mail = ErrorNotifier.invalid_cart_requested(ActiveRecord::RecordNotFound.new)
    assert_equal "Invalid Cart Access Attempt", mail.subject
    assert_equal ["leafar.huaman@gmail.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match "This is just to inform you that an exception was raised and rescued in the Depot app", mail.body.encoded
  end

end
