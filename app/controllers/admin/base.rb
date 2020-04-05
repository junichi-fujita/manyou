class Admin::Base < ApplicationController
  before_action :admin_login_required

  private

  def admin_login_required
    if !logged_in? 
      redirect_to new_user_path
    elsif !logged_in_as_admin?
      redirect_to root_path
    end
  end
end