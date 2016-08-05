require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @membership = memberships(:most_recent)
  end

  #test "should redirect create when not logged in" do
  #  assert_no_difference 'Membership.count' do
  #    post membership_path, params: { membership: { description: "3 mois illimité",
  #    user_id: 3, duration: 3, price: 70.00, start_date: 6.months.ago}}
  #  end
  #  assert_redirected_to connexion_url
  #end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Membership.count' do
      delete membership_path(@membership)
    end
    assert_redirected_to connexion_url
  end
end