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

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      response_to_sign_up_failure resource
    end
  end

  protected


  def response_to_sign_up_failure(resource)
    messages = resource.errors.full_messages.map do |m| "<li>#{m}</li>" end.join("\n")
    flash[:notice] = "<ul>#{messages}<ul>"
    redirect_to new_user_registration_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  #新規登録するときのカラムを許可
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
  end

end