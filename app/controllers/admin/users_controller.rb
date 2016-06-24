class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin, only: [:index, :destroy, :show]
  before_action :load_user, only: [:show, :destroy]

  def index
    @users = User.order(:name).page(params[:page]).per Settings.PAGE_SIZE
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:success] = t "notice.deleted_user_success"
    redirect_to admin_users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "notice.pls_admin"
      redirect_to root_path
    end
  end
end
