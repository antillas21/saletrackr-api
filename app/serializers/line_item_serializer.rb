class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :size, :cost, :qty, :price, :item_cost_total,
    :item_sale_total, :created_at, :updated_at
end
