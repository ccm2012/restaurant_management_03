class CustomersController < ApplicationController
  before_action :find_customer_by_id, only: :show

  def index
    customer_params_code = customer_params[:code]

    return if customer_params_code.blank?
    find_customer customer_params_code
  end

  def new
    @customer = Customer.new
  end

  def create
    customer = Customer.new customer_params
    if customer.save
      session[:customer] = customer
      flash[:success] = t "customer.success_create"
    else
      flash[:danger] = t "customer.fail_create"
      redirect_to root_path
    end
  end

  def show
    customer_orders = customer.orders
    @orders = customer_orders - customer_orders.done
    membership_current = customer.membership_current
    @membership_level =
      if membership_current.present?
        membership_current.name
      else
        "0"
      end
  end

  private

  attr_reader :customer

  def customer_params
    params.require(:customer).permit :name, :email, :phone_num, :code
  end

  def find_customer code
    session[:customer] = Customer.find_by code: code
    session_customer = session[:customer]
    return render json: {status: 0} unless session_customer
    return render json: {status: -1} if session_customer.is_blacklist?
    render json: {status: 1}
  end

  def find_customer_by_id
    @customer = Customer.find_by id: params[:id]
  end
end
