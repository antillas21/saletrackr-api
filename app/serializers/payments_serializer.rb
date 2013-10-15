class PaymentsSerializer < ActiveModel::Serializer
  attributes :id, :uid, :type, :amount, :created_at, :updated_at
  embed :ids, include: true
  has_one :customer, serializer: CustomerMinimalSerializer
end
