require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "veggie burger", description: "Dziwny burger", chef: @user)
  end
  
  test "succesfully deleted recipe" do
    sign_in_as(@user, "password")
    get recipe_path(@recipe)
    assert_template "recipes/show"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete"
    assert_difference "Recipe.count", -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
