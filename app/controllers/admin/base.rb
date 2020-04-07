class Admin::Base < ApplicationController
  before_action :login_required
  before_action :admin_required
  

  private

  def admin_required
    redirect_to root_path unless logged_in_as_admin?
  end
end