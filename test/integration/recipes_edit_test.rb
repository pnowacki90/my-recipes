require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl")
    @recipe = Recipe.create(name: "veggie burger", description: "Dziwny burger", chef: @user)
  end
  
  test "successfull edit of a recipe" do
    get edit_recipe_path(@recipe)
  end
  
  test "edit of a recipe rejected" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: "", description: "cos tam cos tam" } }
    assert_template 'recipes/edit'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
