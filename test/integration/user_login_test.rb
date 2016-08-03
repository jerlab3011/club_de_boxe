require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jerome)
  end
  
  test "login with valid information" do
    get connexion_path
    post connexion_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", connexion_path, count: 0
    assert_select "a[href=?]", deconnexion_path
    assert_select "a[href=?]", user_path(@user)
    delete deconnexion_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", connexion_path
    assert_select "a[href=?]", deconnexion_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end