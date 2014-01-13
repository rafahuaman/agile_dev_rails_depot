class ErrorNotifier < ActionMailer::Base
  default from: "depot@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.invalid_cart_requested.subject
  #
  def invalid_cart_requested(exception)
    @exception = exception

    mail to: "leafar.huaman@gmail.com", subject: 'Invalid Cart Access Attempt'
  end
end
