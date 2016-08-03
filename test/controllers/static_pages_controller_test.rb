require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Club de boxe les Titans"

  end

  test "should get schedule" do
    get static_pages_schedule_url
    assert_response :success
    assert_select "title", "Programmation | Club de boxe les Titans"

  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | Club de boxe les Titans"

  end

end
