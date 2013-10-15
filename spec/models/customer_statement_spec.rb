require 'spec_helper'

describe CustomerStatement do
  let(:customer) { FactoryGirl.create(:customer) }

  it 'relates to a Customer instance' do
    statement = CustomerStatement.new(customer)

    statement.customer.should eq customer
  end

  it 'contains a list of transactions from that Customer' do
    sale = FactoryGirl.create(:sale, customer: customer)
    payment = FactoryGirl.create(:payment, customer: customer)

    statement = CustomerStatement.new(customer)
    statement.transactions.should include(sale, payment)
  end
end