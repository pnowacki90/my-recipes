require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl",
                        password: "password", password_confirmation: "password")
                        
    @user2 = Chef.create!(chefname: "robert", email: "wpsssrs@wsp.pl",
                        password: "1password", password_confirmation: "1password")
                        
    @admin_user = Chef.create!(chefname: "robert", email: "wpssfdsasrs@wsp.pl",
                        password: "1password", password_confirmation: "1password", admin: true)
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
  
  test "accept valid edit" do
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
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "1password")
    get edit_chef_path(@user)
    assert_template "chefs/edit"
    patch chef_path(@user), params: { chef: { chefname: "kleko1tek", email: "kjbtsadksjb@wp.pl" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "kleko1tek", @user.chefname
    assert_match "kjbtsadksjb@wp.pl", @user.email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@user2, "1password")
    updated_name = "Joe"
    updated_email = "saoljuns@wp.pl"
    patch chef_path(@user), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @user.reload
    assert_match "piotrek", @user.chefname
    assert_match "wpssss@wp.pl", @user.email
  end
end
