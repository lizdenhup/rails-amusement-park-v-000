class SessionsController < ApplicationController

  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id 
      redirect_to user_path(@user), notice: "Welcome back, #{@user.name}."
    else 
      redirect_to signin_path 
    end 
  end 

  def destroy
    @user = User.find_by_id(params[:id])
    session.destroy
    redirect_to root_path 
  end 
  
end
