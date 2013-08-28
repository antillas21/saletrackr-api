class V1::PaymentsController < ApplicationController
  before_action :fetch_resource, except: [:index]

  def index
    @payments = current_user.payments
    respond_with @payments, location: v1_payments_url
  end

  def show
    respond_with @resource, location: v1_payment_url(@resource)
  end

  def update
    @resource.update_attributes(payment_params)
    respond_with @resource, location: v1_payment_url(@resource)
  end

  def destroy
    @resource.destroy
    head :ok
  end

  private
  def fetch_resource
    super(:payments)
  end

  def payment_params
    params.require(:payment).permit(:amount, :customer_id)
  end
end
