require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:bobby)
    @non_admin = users(:timmy)
    @non_active = users(:michael)
    @archer = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
# NEEDS FIXING **********************************
    # first_page_of_users.each do |user|
    #   assert_select 'a[href=?]', user_path(user), user.name
    #   unless user == @admin
    #     assert_select 'a[href=?]', user_path(user), text: 'delete'
    #   end
    # end
# NEEDS FIXING **********************************
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin has no delete links" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index shows only activated users" do
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@non_active), count: 0
    assert_select "a[href=?]", user_path(@non_admin), count: 2
    assert_select "a[href=?]", user_path(@archer), count: 1
  end

end





  # test "index including pagination" do
  #   log_in_as(@user)
  #   get users_path
  #   assert_template 'users/index'
  #   assert_select 'div.pagination', count: 2
    # User.paginate(page: 1).each do |user|
      # assert_select 'a[href=?]', user_path(@user), text: @user.name
    # end
  # end