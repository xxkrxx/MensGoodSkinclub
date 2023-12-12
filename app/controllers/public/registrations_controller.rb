# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy
  #新規登録のアクションが行われる前にconfigure_sign_up_paramsメソッド実行
  before_action :configure_sign_up_params, only: [:create]
  
   
  # before_action :configure_account_update_params, only: [:update]
  
  #サインアップ後のリダイレクト先を指定
  def after_sign_up_path_for(resource)
    flash[:notice] = "welcome Mens SkinClub"
    user_path(current_user)
  end
  
  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  #新規登録するときのカラムを許可
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
  end

end