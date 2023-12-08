class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user =User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:admin_customer] = "更新成功"
      redirect_to admin_users_path(@user)
    end
    render :edit
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image_id, :profile, :skin_concerns_id, :is_active)
  end  
  
end
