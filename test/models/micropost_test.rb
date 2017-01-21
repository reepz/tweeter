require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:archer)
    # could be written better
    # @micropost = Micropost.new(content: "Patience and discipline.", user_id: @user.id)
    @micropost = @user.microposts.build(content: "Chubakka!")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "micropost user_id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "  "
    assert_not @micropost.valid?
  end

  test "content should be no longer than 160 chars" do
    @micropost.content = "S"*161
    assert_not @micropost.valid?
  end

  test "microposts should be sorted from newest to oldest" do
    assert_equal microposts(:most_recent), Micropost.first
  end

end
