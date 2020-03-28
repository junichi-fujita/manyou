class Admin::Base < ApplicationController
  before_action :admin_login_required

  private

  def admin_login_required
    if !current_user
      redirect_to new_user_path
    elsif !current_user.administrator?
      redirect_to root_path
    end
  end
end