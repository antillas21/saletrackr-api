class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :uid, :type, :amount, :created_at, :updated_at
end
