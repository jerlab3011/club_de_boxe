require 'test_helper'

class MembersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:jerome)
    @non_admin = users(:emilie)
    @member = Member.first
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get members_path
    assert_template 'members/index'
    first_page_of_members = Member.paginate(page: 1)
    first_page_of_members.each do |member|
      assert_select 'a[href=?]', member_path(member), text: member.full_name
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get members_path
    assert_redirected_to root_url
  end

end
