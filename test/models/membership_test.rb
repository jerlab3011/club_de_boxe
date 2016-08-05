require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  def setup
    @user = users(:jerome)
    @membership = @user.memberships.build(description: "3 mois illimité", duration: 3, price:50, start_date: Time.now)
  end

  test "should be valid" do
    assert @membership.valid?
  end

  test "user id should be present" do
    @membership.user_id = nil
    assert_not @membership.valid?
  end
  
  test "description should be present" do
    @membership.description = nil
    assert_not @membership.valid?
  end
  
  test "duration should be present" do
    @membership.duration = nil
    assert_not @membership.valid?
  end
  
  
  test "start_date should be present" do
    @membership.start_date = nil
    assert_not @membership.valid?
  end
  
  test "order should be most recent end_date first" do
    assert_equal memberships(:most_recent), Membership.first
  end
  
  test "membership should be created" do
    @user.save
    assert_difference 'Membership.count', 1 do
      @user.memberships.create!(description: "12 mois illimité",
      duration: 12, price: 120.00, start_date: 2.years.ago)
    end
  end
  
  test "End_date should have right values" do
    @user.save
    membership = @user.memberships.create!(description: "Illimité",
      duration: 12, start_date: 2.years.ago)
    assert_equal membership.start_date + 1.year, membership.end_date
  end
  
  test "Price should have right values" do
    @user.save
    membership = @user.memberships.create!(description: "Illimité",
      duration: 12, start_date: 2.years.ago)
    assert_equal 400, membership.price
  end
  
  
end
