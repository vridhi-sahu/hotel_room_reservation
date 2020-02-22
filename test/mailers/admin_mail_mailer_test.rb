require 'test_helper'

class AdminMailMailerTest < ActionMailer::TestCase
  test "admin_email" do
    mail = AdminMailMailer.admin_email
    assert_equal "Admin email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
