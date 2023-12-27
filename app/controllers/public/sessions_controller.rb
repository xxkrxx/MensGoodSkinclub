# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]
  # サインインする前に reject_user メソッドを実行

  before_action :configure_sign_in_params, only: [:create]
  # サインインする前に configure_sign_in_params メソッドを実行
  before_action :user_state, only: [:creste]
  # サインインする前に user_state メソッドを実行

  def after_sign_in_path_for(resource)
    flash[:notice] = "welcome Mens SkinClub"
    users_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def destory
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :alert, signed_out if signed_out
    respond_to_on_destory
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  # サインイン時のカラムの許可
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end
end
