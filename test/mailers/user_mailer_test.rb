require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:jerome)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Activation du compte", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["admin@boxetitans.com"], mail.from
    assert_match user.first_name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
