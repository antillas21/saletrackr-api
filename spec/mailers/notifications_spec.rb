require "spec_helper"

describe Notifications do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let(:payment) { create(:payment, customer: customer) }
  let(:sale) { create(:sale, customer: customer) }

  describe 'sale receipt' do
    let!(:email) { Notifications.payment_receipt(payment, customer, user) }

    it 'should be delivered to customer email owning payment' do
      email.should deliver_to "#{customer.name} <#{customer.email}>"
    end

    it 'contains PAYMENT RECEIPT in mail body copy' do
      email.should have_body_text /PAYMENT RECEIPT/
    end

    it 'contains Your recent purchase with store owner\'s name as subject' do
      email.should have_subject "Payment Receipt to #{user.email}"
    end
  end

  describe 'payment receipt' do
    let!(:email) { Notifications.sale_receipt(sale, customer, user) }

    it 'should be delivered to customer email owning payment' do
      email.should deliver_to "#{customer.name} <#{customer.email}>"
    end

    it 'contains PAYMENT RECEIPT in mail body copy' do
      email.should have_body_text /SALE RECEIPT/
    end

    it 'contains Your recent purchase with store owner\'s name as subject' do
      email.should have_subject "Your recent purchase with #{user.email}"
    end
  end
end
