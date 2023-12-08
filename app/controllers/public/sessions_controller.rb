# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
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


end
