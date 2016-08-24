require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def setup
    @user = users(:emilie)
    @user.members.build(first_name: "FirstName",last_name:"LastName", birth_date: "2008-08-20", phone: "514-345-5678",
    postal_code: "H2P 2G3", address: "1234 marquette", gender:"M")
    @user.save
    @member = @user.members.first
  end

  test "should be valid" do
    assert @member.valid?
  end
  
  test "First name should be present" do
    @member.first_name = "     "
    assert_not @member.valid?
  end
  
  test "Last name should be present" do
    @member.last_name = "     "
    assert_not @member.valid?
  end
  
  test "phone should be present" do
    @member.phone = "     "
    assert_not @member.valid?
  end
  
  test "address should be present" do
    @member.address = "     "
    assert_not @member.valid?
  end
  
    
  test "postal code should be present" do
    @member.postal_code = "     "
    assert_not @member.valid?
  end
  
  test "birth date should be present" do
    @member.birth_date = "     "
    assert_not @member.valid?
  end
  
  test "user_id shoudl be present" do
    @member.user_id = " "
    assert_not @member.valid?
  end
  
  test "First name should not be too long" do
    @member.first_name = "a" * 51
    assert_not @member.valid?
  end
  
  test "Last name should not be too long" do
    @member.last_name = "a" * 51
    assert_not @member.valid?
  end

  test "address should not be too long" do
    @member.address = "a" * 244 + "@example.com"
    assert_not @member.valid?
  end
  

  test "phone validation should accept valid numbers" do
    valid_numbers = ["123-456-7890", "123 456-1234", "(123) 123-1234", "(123)456-7890", "1234567890"]
    valid_numbers.each do |valid_number|
      @member.phone = valid_number
      assert @member.valid?, "#{valid_number.inspect} should be valid"
    end
  end
  
  test "phone validation should reject invalid number" do
    invalid_numbers = ["123", "123a4566789", ""]
    invalid_numbers.each do |invalid_number|
      @member.phone = invalid_number
      assert_not @member.valid?, "#{invalid_number.inspect} should be invalid"
    end
  end
  
  test "postal_code validation should accept valid codes" do
    valid_codes = ["a2b 3c4", "j6k4k4", "J9F9J3", "J3j 0a9"]
    valid_codes.each do |valid_code|
      @member.postal_code = valid_code
      assert @member.valid?, "#{valid_code.inspect} should be valid"
    end
  end
  
  test "postal_code validation should reject invalid codes" do
    invalid_codes = ["123 abc", "abc123", "", "h3k2j", "9J0 J9H"]
    invalid_codes.each do |invalid_code|
      @member.postal_code = invalid_code
      assert_not @member.valid?, "#{invalid_code.inspect} should be invalid"
    end
  end
  
  test "birth_date validation should accept valid dates" do
    valid_dates = ["1984-11-30", "30-11-1984", "30 novembre 1984"]
    valid_dates.each do |valid_date|
      @member.birth_date = valid_date
      assert @member.valid?, "#{valid_date.inspect} should be valid"
    end
  end
  
  test "birth_date validation should reject invalid dates" do
    invalid_dates = ["190-109-20", "1984-30-11", "1984-11-31", "30-1984-30", "30 patates 1984"]
    invalid_dates.each do |invalid_date|
      @member.birth_date = invalid_date
      assert_not @member.valid?, "#{invalid_date.inspect} should be invalid"
    end
  end
  
end
