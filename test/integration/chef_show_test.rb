require 'test_helper'

class ChefShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "veggie burger", description: "Dziwny burger", chef: @user)
    @recipe2 = @user.recipes.build(name: "pesto", description: "bazylia i parmezan")
    @recipe2.save
  end
  
  test "should get chef show" do
    get chef_path(@user)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @user.chefname, response.body
  end
end
