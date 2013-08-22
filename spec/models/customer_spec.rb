require 'spec_helper'

describe Customer do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :sales }
    it { should have_many :payments }

    it { should belong_to :user }
  end

  describe '#total_sales' do
    let(:customer) { create(:customer) }

    it 'returns sum of sale amounts' do
      2.times do
        item = build(:coat)
        sale = create(:sale, customer: customer, line_items: [item])
      end
      customer.total_sales.should == 2400.0
    end
  end

  describe '#total_payments' do
    let(:customer) { create(:customer) }

    it 'returns sum of payment amounts' do
      2.times { create(:payment, amount: 900.0, customer: customer) }
      customer.total_payments.should == 1800.0
    end
  end

  describe "#balance" do
    let(:customer) { create(:customer) }

    it 'returns balance between sales and payments' do
      2.times do
        item = build(:coat)
        sale = create(:sale, customer: customer, line_items: [item])
      end
      1.times { create(:payment, customer: customer) }

      customer.balance.should_not == 0

      customer.balance.should == ( customer.total_sales - customer.total_payments )
    end
  end

end
