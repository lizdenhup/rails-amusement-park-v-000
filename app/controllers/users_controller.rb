class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to user_path(@user)
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end 

  private

    def user_params
        params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height)
    end 

end
