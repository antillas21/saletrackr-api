class V1::CustomersController < ApplicationController
  before_action :fetch_resource, except: [:index]

  def index
    @customers = Customer.all
    respond_with @customers
  end

  def show
    respond_with @resource
  end

  def update
    @resource.update_attributes(customer_params)
    respond_with @customer, location: v1_customer_url(@customer)
  end

  def destroy
    @resource.destroy
    head :ok
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
