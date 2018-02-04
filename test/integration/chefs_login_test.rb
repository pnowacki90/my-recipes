require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname: "katarzyna", email: "karasek@wp.pl", password: "haslo")
  end
  
  test "invalid log in is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "valid login accepted begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "karasek@wp.pl", password: "haslo" } }
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
