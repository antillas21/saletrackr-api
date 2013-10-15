class CustomerStatementSerializer < ActiveModel::Serializer
  # embed :id, include: true
  has_one :customer, serializer: CustomerSerializer
  has_many :transactions, serializer: TransactionSerializer
end
