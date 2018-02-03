require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl",
                        password: "password", password_confirmation: "password")
    @user2 = Chef.create!(chefname: "robert", email: "wpsssrs@wsp.pl",
                        password: "1password", password_confirmation: "1password")
  end
  
  test "should get chefs index" do
    get chefs_url
    assert_response :success
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@user), text: @user.chefname.capitalize
    assert_select "a[href=?]", chef_path(@user2), text: @user2.chefname.capitalize
  end
  
  test "should delete chef" do
    get chefs_path
    assert_template "chefs/index"
    assert_difference 'Chef.count', -1 do
      delete chef_path(@user2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
