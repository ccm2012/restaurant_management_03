class CustomersController < ApplicationController
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

  private

  attr_reader :customer

  def customer_params
    params.require(:customer).permit :name, :email, :phone_num, :code
  end

  def find_customer code
    session[:customer] = Customer.find_by code: code

    return if session[:customer]
    flash[:danger] = t "customer.not_found"
    redirect_to :back
  end
end
