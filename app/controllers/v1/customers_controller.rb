class V1::CustomersController < ApplicationController
  before_action :fetch_resource, only: [:show, :update, :destroy, :statement]

  def index
    @customers = current_user.customers
    respond_with @customers
  end

  def show
    respond_with @resource
  end

  def update
    @resource.update_attributes(customer_params)
    respond_with @resource, location: v1_customer_url(@resource)
  end

  def destroy
    @resource.destroy
    head :ok
  end

  def statement
    respond_with @resource, serializer: CustomerStatementSerializer,
      location: statement_v1_customer_url(@resource)
  end

  private

  def customer_params
    params.require( :customer ).permit( :name, :phone, :email )
  end

  def fetch_resource
    super(:customers)
  #   customer = Customer.find( params[:id] )
  #   if current_user.customers.include?(customer)
  #     @customer = customer
  #   else
  #     render json: authorization_error_message, status: 403
  #   end
  # rescue ActiveRecord::RecordNotFound
  #   render json: resource_not_found_error_message, status: 404
  end
end
