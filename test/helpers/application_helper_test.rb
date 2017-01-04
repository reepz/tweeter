require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Twi77er"
    assert_equal full_title("Help"), "Help | Twi77er"
  end
end
