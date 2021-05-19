class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @item = @user.items.includes(:user)
  end
  
end
