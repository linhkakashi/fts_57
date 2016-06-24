class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for :sign_up do |u|
      u.permit :name, :email, :password, :password_confirmation, :remember_me
    end
    devise_parameter_sanitizer.for :account_update do |u|
      u.permit :name, :email, :password, :password_confirmation, :current_password
    end
  end

  def logged_in_user
    unless user_signed_in?
      flash[:danger] = t "notice.pls_login"
      redirect_to new_user_session_url
    end
  end
end
