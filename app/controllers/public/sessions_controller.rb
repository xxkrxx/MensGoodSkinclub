# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_customer, only: [:create]
   #サインインする前にconfigure_sign_in_paramsメソッド実行
  before_action :configure_sign_in_params, only: [:create]
  #サインインする前にcustomer_state実行
  before_action :user_state,only: [:creste]

  def after_sign_in_path_for(resource)
    flash[:notice] = "welcome Mens SkinClub"
      users_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def destory
    signed_out =(Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :alert, signed_out if signed_out
    respond_to_on_destory
  end

  protected

   #サインインするときのカラムの許可
   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:emai])
   end
   
  def reject_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_end_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end
end