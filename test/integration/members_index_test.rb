require 'test_helper'

class MembersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:jerome)
    @non_admin = users(:emilie)
    @member = @non_admin.members.first
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get members_path
    assert_template 'members/index'
    first_page_of_members = User.paginate(page: 1)
    first_page_of_members.each do |member|
      assert_select 'a[href=?]', member_path(member), text: member.full_name
      assert_select 'a[href=?]', user_path(user), text: 'supprimer'
    end
    assert_difference 'Member.count', -1 do
      delete member_path(@member)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get members_path
    assert_redirected_to root_url
  end

end
