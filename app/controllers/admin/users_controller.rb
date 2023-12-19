class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
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
      flash[:notice] = "登録情報を編集しました"
      redirect_to admin_users_path(@user)
    else
      flash[:alert] = "登録情報の編集に失敗しました"
      render :edit  
    end
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image_id, :profile, :skin_concerns_id, :is_active)
  end  
  
end
