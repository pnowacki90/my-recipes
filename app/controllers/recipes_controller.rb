class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :update, :edit, :destroy]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash[:success] = "Recipe saved!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def edit
    if @recipe.chef != current_chef
      flash[:danger] = "You are not allowed to edit recipes that don't belong to you!"
      redirect_to recipe_path(@recipe)
    end
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe updated correctly!"
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end
  
  def destroy
    if @recipe.chef != current_chef
      flash[:danger] = "You are not allowed to delete recipes that don't belong to you!"
      redirect_to recipe_path(@recipe)
    end
    set_recipe.destroy
    flash[:success] = "Recipe deleted!"
    redirect_to recipes_path
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end