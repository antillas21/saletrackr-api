class V1::LineItemsController < ApplicationController
  before_action :fetch_resource, except: [:index]

  def index
    @line_items = current_user.line_items
    respond_with @line_items, location: v1_line_items_url
  end

  def show
    respond_with @resource, location: v1_line_item_url(@resource)
  end

  def update
    @resource.update_attributes(line_item_params)
    respond_with @resource, location: v1_line_item_url(@resource)
  end

  def destroy
    @resource.destroy
    head :ok
  end

  private
  def line_item_params
    params.require(:line_item).permit(
      :id, :name, :qty, :color, :size, :price, :cost, :sale_id
    )
  end

  def fetch_resource
    super(:line_items)
  end
end