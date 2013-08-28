class V1::SalesController < ApplicationController
  before_action :fetch_resource, except: [:index]

  def index
    @sales = current_user.sales
    respond_with @sales, location: v1_sales_url
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
end