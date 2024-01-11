class Admin::UsersController < ApplicationController
  
  # すべてのユーザーの一覧を表示
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  # 特定のユーザーの詳細情報を表示
  def show
    @user = User.find(params[:id])
  end

  # 特定のユーザーの編集フォームを表示
  def edit
    @user = User.find(params[:id])
  end

  # 特定のユーザーの情報を更新
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
  
  # ユーザーのデータに対するストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :profile_image_id, :profile, :skin_concerns_id, :is_active)
  end  
end

