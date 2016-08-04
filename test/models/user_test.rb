require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "FirstName",last_name:"LastName", email: "user@example.com", birth_date: "2008-08-20", phone: "514-345-5678",
    postal_code: "H2P 2G3", address: "1234 marquette", gender:"M", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "First name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end
  
  test "Last name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "phone should be present" do
    @user.phone = "     "
    assert_not @user.valid?
  end
  
  test "address should be present" do
    @user.address = "     "
    assert_not @user.valid?
  end
  
    
  test "postal code should be present" do
    @user.postal_code = "     "
    assert_not @user.valid?
  end
  
  test "birth date should be present" do
    @user.birth_date = "     "
    assert_not @user.valid?
  end
  
  test "First name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end
  
  test "Last name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  

  test "address should not be too long" do
    @user.address = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "phone validation should accept valid numbers" do
    valid_numbers = ["123-456-7890", "123 456-1234", "(123) 123-1234", "(123)456-7890", "1234567890"]
    valid_numbers.each do |valid_number|
      @user.phone = valid_number
      assert @user.valid?, "#{valid_number.inspect} should be valid"
    end
  end
  
  test "phone validation should reject invalid number" do
    invalid_numbers = ["123", "123a4566789", ""]
    invalid_numbers.each do |invalid_number|
      @user.phone = invalid_number
      assert_not @user.valid?, "#{invalid_number.inspect} should be invalid"
    end
  end
  
  test "postal_code validation should accept valid codes" do
    valid_codes = ["a2b 3c4", "j6k4k4", "J9F9J3", "J3j 0a9"]
    valid_codes.each do |valid_code|
      @user.postal_code = valid_code
      assert @user.valid?, "#{valid_code.inspect} should be valid"
    end
  end
  
  test "postal_code validation should reject invalid codes" do
    invalid_codes = ["123 abc", "abc123", "", "h3k2j", "9J0 J9H"]
    invalid_codes.each do |invalid_code|
      @user.postal_code = invalid_code
      assert_not @user.valid?, "#{invalid_code.inspect} should be invalid"
    end
  end
  
  test "birth_date validation should accept valid dates" do
    valid_dates = ["1984-11-30", "30-11-1984", "30 novembre 1984"]
    valid_dates.each do |valid_date|
      @user.birth_date = valid_date
      assert @user.valid?, "#{valid_date.inspect} should be valid"
    end
  end
  test "birth_date validation should reject invalid dates" do
    invalid_dates = ["190-109-20", "1984-30-11", "1984-11-31", "30-1984-30", "30 patates 1984"]
    invalid_dates.each do |invalid_date|
      @user.birth_date = invalid_date
      assert_not @user.valid?, "#{invalid_date.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end