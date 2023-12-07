# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :alert, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end


  protected
  
  #ログインした場合
  def after_sign_in_path_for(resource)
    admin_skinitems_path
  end
  
  #ログアウトした場合
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
  
  private
  
  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

end
