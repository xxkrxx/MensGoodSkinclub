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
  if @user.update(user_params)
     flash[:notice] = "ユーザー情報を更新しました。"
     redirect_to user_path(@user)
  else
     flash[:alert] = "ユーザー情報の更新に失敗しました。入力内容を確認してください。"
     render :edit
  end
  
  def withdraw
    @user = User.find(current_user.id)
    if @user.update(is_active: false)
      reset_session
      flash[:notice] = "退会処理を実行いたしました。"
      redirect_to root_path
    else
      flash[:alert] = "退会処理に失敗しました。もう一度お試しください。"
      redirect_to user_path(@user)
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :profile , :profile_image )
  end

end
