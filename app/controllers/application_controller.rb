# :reek:PrimaDonnaMethod { exclude: [ authenticate_staff! ] }
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  include CustomerHelper

  def current_ability
    @current_ability ||= Ability.new current_staff
  end

  def after_sign_in_path_for staff
    session[:previous_url] || redirect_path(staff)
  end

  protected

  def authenticate_staff!
    if staff_signed_in?
      super
    else
      session[:previous_url] = request.fullpath
      redirect_to login_path
      flash[:danger] = t "flash.staff.notloggedin"
    end
  end

  private

  def redirect_path user
    if user.is_a? Customer
      root_path
    else
      default_role_redirect user
    end
  end

  def default_role_redirect staff
    case staff.staff_role
    when "administrator"
      admin_dashboards_path
    when "receptionist"
      admin_orders_path
    when "chef"
      admin_chef_index_path
    when "waiter"
      staffs_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to staffs_path, flash: {danger: exception.message}
  end
end
