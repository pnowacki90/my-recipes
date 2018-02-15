class RatingsController < ApplicationController
  
  before_action :require_user
  
  def update
    @rating = Rating.find(params[:id])
    @recipe = @rating.recipe
    if @rating.update_attributes(rate: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end
  
  private
  
  def rating_params
    params.require(:rating).permit(:rate)
  end
  
end
