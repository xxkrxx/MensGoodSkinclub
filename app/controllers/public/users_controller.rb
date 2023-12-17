class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def check
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  def withdraw
  @user = User.find(current_user.id)
  @user.update(is_active: false)
  reset_session
  flash[:notice] = "退会処理を実行いたしました"
  redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :profile , :profile_image )
  end

end
