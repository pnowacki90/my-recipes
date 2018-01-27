require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl")
    @recipe = Recipe.create(name: "veggie burger", description: "Dziwny burger", chef: @user)
    @recipe2 = @user.recipes.build(name: "pesto", description: "bazylia i parmezan")
    @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
    
  end
end
