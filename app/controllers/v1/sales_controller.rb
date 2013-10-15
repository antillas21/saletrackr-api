class V1::SalesController < ApplicationController
  before_action :fetch_resource, except: [:index]

  def index
    @sales = current_user.sales
    respond_with @sales.includes(:customer, :line_items), 
      each_serializer: SalesSerializer, location: v1_sales_url
  end

  def show
    respond_with @resource, location: v1_sale_url(@resource)
  end

  def update
    @resource.update_attributes(sale_params)
    respond_with @resource, location: v1_sale_url(@resource)
  end

  def destroy
    @resource.destroy
    head :ok
  end

  def receipt
    Notifications.sale_receipt( @resource, @resource.customer, current_user ).deliver
    render json: receipt_message, status: 200
  end

  private
  def fetch_resource
    super(:sales)
  end

  def sale_params
    params.require(:sale).permit(
      :amount, :customer, :customer_id,
      line_items_attributes: [:name, :color, :size, :cost, :price, :qty]
    )
  end

  def receipt_message
    {
      message: 'Sale receipt has been queued for delivery.',
      kind: 'Successful Operation.'
    }
  end

end