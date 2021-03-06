class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:show, :update, :edit, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    if logged_in?
      @rating = Rating.where(recipe_id: @recipe.id, chef_id: current_chef.id).first
      unless @rating
        @rating = Rating.create!(recipe_id: @recipe.id, chef_id: current_chef.id, rate: 0)
      end
    end
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
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
    set_recipe.destroy
    flash[:success] = "Recipe deleted!"
    redirect_to recipes_path
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:name, :description, ingredient_ids: [])
  end
  
  def require_same_user
    if @recipe.chef != current_chef and !current_chef.admin?
      flash[:danger] = "You are allowed to delete and edit recipes that belong to you!"
      redirect_to recipes_path
    end
  end
end