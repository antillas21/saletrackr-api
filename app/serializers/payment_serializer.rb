class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :uid, :type, :amount, :created_at, :updated_at
  has_one :customer, serializer: CustomerSerializer
end
