class Public::UsersController < ApplicationController
  # ユーザー一覧を取得
  def index
    @users = User.all.page(params[:page]).per(9)
  end

  def check
  end

  # 特定のユーザーの詳細情報を取得
  def show
    @user = User.find(params[:id])
  end

  # 特定のユーザーの編集ページを表示
  def edit
    @user = User.find(params[:id])
  end


  def favorites
    @user = User.find(params[:id])
    favorites= Itemfavorite.where(user_id: @user.id).pluck(:skinitem_id)
    @favorite_posts = Skinitem.find(favorites)
  end


  # ユーザー情報の更新を処理
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "ユーザー情報の更新に失敗しました。入力内容を確認してください。"
      render :edit
    end
  end

  # 退会処理を実行
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

  # パラメータの許可
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
