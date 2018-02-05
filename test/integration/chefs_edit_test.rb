require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl",
                        password: "password", password_confirmation: "password")
  end
  
  test "Reject an invalid edit" do
    sign_in_as(@user, "password")  
    get edit_chef_path(@user)
    assert_template "chefs/edit"
    patch chef_path(@user), params: { chef: { chefname: "", email: "kjbsadkjb@wp.pl" } }
    assert_template 'chefs/edit'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "accept valid signup" do
    sign_in_as(@user, "password")
    get edit_chef_path(@user)
    assert_template "chefs/edit"
    patch chef_path(@user), params: { chef: { chefname: "klekotek", email: "kjbsadksjb@wp.pl" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "klekotek", @user.chefname
    assert_match "kjbsadksjb@wp.pl", @user.email
  end
end
