class ApplicationController < ActionController::Base
  helper_method :current_user
  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  private 

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    unless current_user
      redirect_to new_user_path
    end
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_as_admin?
    current_user.administrator?
  end
end
