require 'test_helper'

class ChefsSignUpTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create(chefname: "Maciek", email: "manerge@onet.pl", password: "haslo", password_confirmation: "haslo")
  end
  
  test "should get sign up path" do
    get signup_path
    assert_response :success
  end
  
  test "Reject an invalid signup" do
    get signup_path
    assert_template "chefs/new"
    assert_no_difference "Chef.count" do
      post chefs_path, params: { chef: { chefname: "", email: "", password: "password", password_confirmation: "" } }
    end
    assert_template 'chefs/new'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "accept valid signup" do
    get signup_path
    assert_template "chefs/new"
    assert_difference "Chef.count", 1 do
      post chefs_path, params: { chef: { chefname: "peter", email: "hbdsahkbas@djsabnk.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
end
