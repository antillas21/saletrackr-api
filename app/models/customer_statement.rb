class CustomerStatement
  include ActiveModel::SerializerSupport

  attr_accessor :customer, :transactions

  def initialize(customer)
    @customer = customer
  end

  def transactions
    @customer.transactions
  end
end