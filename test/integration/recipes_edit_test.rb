require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = Chef.create!(chefname: "piotrek", email: "wpssss@wp.pl", 
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "veggie burger", description: "Dziwny burger", chef: @user)
  end
  
  test "successfull edit of a recipe" do
    sign_in_as(@user, "password")    
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    name1 = "updated recipe name"
    description1 = "decription of a recipe"
    patch recipe_path(@recipe), params: { recipe: { name: name1, description: description1 } }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match name1, @recipe.name
    assert_match description1, @recipe.description
  end
  
  test "edit of a recipe rejected" do
    sign_in_as(@user, "password")  
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: "", description: "cos tam cos tam" } }
    assert_template 'recipes/edit'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
