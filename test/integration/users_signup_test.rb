require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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
  
test "valid signup information" do
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
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end