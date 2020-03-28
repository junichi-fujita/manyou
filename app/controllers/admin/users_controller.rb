class Admin::UsersController < Admin::Base
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_root_path, notice: "「#{@user.name}」を登録しました。"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to admin_root_path, notice: "「#{@user.name}」を変更しました。"
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_root_path, notice: "「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :administrator,
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
