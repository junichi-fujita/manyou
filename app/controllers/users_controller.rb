class UsersController < ApplicationController
  before_action :login_required, only: :show
  before_action :set_user, only: :show
  
  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def show
    if logged_in_as_admin? || @user == current_user
      render :show
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "「#{@user.name}」を登録しました。"
    else
      render :new
    end
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

  def only_my_pege
    if User.find(params: id) != current_user.id
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
