class V1::CustomersController < ApplicationController
  before_action :fetch_customer, only: [:show]

  def index
    @customers = Customer.all
    respond_with @customers
  end

  def show
    respond_with @customer
  end

  private

  def fetch_customer
    @customer = current_user.customers.find( params[:id] )
  rescue ActiveRecord::RecordNotFound
    error = { error: "Record could not be found or access is not allowed." }
    respond_with error, status: 404
  end
end
