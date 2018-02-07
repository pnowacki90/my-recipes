class IngredientsController < ApplicationController
  
  before_action :require_admin, except: [:show, :index]
  before_action :set_ingredient, only: [:show, :edit, :update]
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)

  end
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient added!"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient updated"
      redirect_to ingredient_path(@ingredient)
    else
      render 'edit'
    end
  end
  
  private
  
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_chef.admin?)
      flash[:danger] = "Only admin can perform that action!"
      redirect_to ingredients_path
    end
  end
end
