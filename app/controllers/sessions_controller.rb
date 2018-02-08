class SessionsController < ApplicationController
  
  def new
  
  end

  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      cookies.signed[:chef_id] = chef.id
      flash[:success] = "Welcome #{chef.chefname.capitalize}!"
      redirect_to chef_path(chef)
    else
      flash.now[:danger] = "Wrong email or password!"
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You are logged out!"
    redirect_to login_path
  end
end
