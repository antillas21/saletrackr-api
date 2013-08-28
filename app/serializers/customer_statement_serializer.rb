class CustomerStatementSerializer < ActiveModel::Serializer
  attributes :id, :uid, :name, :email, :phone, :balance, :created_at, :updated_at
  has_many :transactions, serializer: TransactionSerializer
end
