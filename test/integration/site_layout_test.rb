require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:timmy)
  end

  test "layout links for non logged users" do
    get root_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get root_path
    assert_select "title", full_title
  end

  test "links for logged users" do
    log_in_as(@user)
    get users_path
    assert_select "title", full_title("All users")
    get user_path(@user)
    get edit_user_path(@user)
    delete logout_path
  end
end
