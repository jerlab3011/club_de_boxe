require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @payment = payments(:most_recent)
  end

  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Payment.count' do
      delete payment_path(@payment)
    end
    assert_redirected_to connexion_url
  end

end
