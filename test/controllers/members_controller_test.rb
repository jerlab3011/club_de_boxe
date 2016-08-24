require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:jerome)
    @user = users(:emilie)
    @other_user = users(:archer)
    @member = @user.members.first
  end

  test "should get edit when logged in as admin" do
    log_in_as(@admin)
    get edit_member_path(@member)
    assert_response :success
  end
  
  test "should get edit when logged in as correct user" do
    log_in_as(@user)
    get edit_member_path(@member)
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get edit_member_path(@member)
    assert_not flash.empty?
    assert_redirected_to connexion_url
  end


  test "should allow update when logged in as admin" do
    log_in_as(@admin)
    patch member_path(@member), params: { member: { last_name: "Labonté"} }
    assert_equal @member.reload.last_name, "Labonté"
  end
  
  test "should allow update when logged in as correct user" do
    log_in_as(@user)
    patch member_path(@member), params: { member: { last_name: "Labonté"} }
    assert_equal @member.reload.last_name, "Labonté"
  end
  
  test "should redirect update when not logged in" do
    patch member_path(@member), params: { member: { last_name: @member.last_name} }
    assert_not flash.empty?
    assert_redirected_to connexion_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_member_path(@member)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch member_path(@member), params: { member: { last_name: @member.last_name} }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should get index when logged as admin" do
    log_in_as(@admin)
    get members_path
    assert_response :success
  end
  
  test "should redirect index when not logged in" do
    get members_path
    assert_redirected_to connexion_url
  end
  
  test "should redirect index when logged as non-admin" do
    log_in_as(@user)
    get members_path
    assert_redirected_to root_url
  end

  test "should destroy member when user is destroyed" do
    log_in_as(@admin)
    assert_difference 'Member.count', -1 do
      delete user_path(@user)
    end
  end
  
end
