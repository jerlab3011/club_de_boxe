require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do
    get inscription_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { last_name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
test "valid signup information with account activation" do
    get inscription_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name:  "Example",
                                         last_name: "User",
                                         email: "user@example.com",
                                         address: "1234 Adresse",
                                         phone: "514-123-4567",
                                         postal_code: "H0H 0H0",
                                         gender: "M",
                                         birth_date: "1900-01-01",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end