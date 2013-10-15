class SalesSerializer < ActiveModel::Serializer
  attributes :id, :uid, :type, :amount, :cost, :created_at, :updated_at
  embed :ids, include: true
  has_one :customer, serializer: CustomerMinimalSerializer
  # has_many :line_items
end
