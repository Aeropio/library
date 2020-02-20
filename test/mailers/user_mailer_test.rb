require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "sign_up_notification" do
    mail = UserMailer.sign_up_notification
    assert_equal "Sign up notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "approved_notification" do
    mail = UserMailer.approved_notification
    assert_equal "Approved notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "rejected_notification" do
    mail = UserMailer.rejected_notification
    assert_equal "Rejected notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
