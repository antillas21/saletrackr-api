class SaleSerializer < ActiveModel::Serializer
  attributes :id, :uid, :type, :amount, :cost, :created_at, :updated_at
  has_one :customer, serializer: CustomerSerializer
  has_many :line_items
end
