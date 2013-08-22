require 'spec_helper'

describe Sale do
 describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :line_items }
  end

  describe 'validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :customer_id }
  end

  describe 'amount' do
    let(:item) { build(:coat) }
    let(:sale) { create(:sale, line_items: [item]) }

    it 'is auto-calculated with the sum of all line_items' do
      # sale = FactoryGirl.create(:sale_and_items)
      sale.amount.should_not == 0
      sale.amount.should == 1200.0
    end
  end

  describe 'total_cost' do
    let(:item) { build(:coat, cost: 900, qty: 3) }
    let(:sale) { create(:sale, line_items: [item]) }

    it 'auto-calculates total cost based on the sum of all line items costs' do
      sale.cost.should_not == 0
      sale.cost.should eq 2700.0
    end
  end

  describe 'deleting a sale' do
    let(:sale) { create(:sale) }

    it 'deletes associated line_items' do
      item = build(:coat, sale: sale)
      sale.line_items << item
      sale.save

      LineItem.count.should == 1
      sale.line_items.should include item

      expect{ sale.destroy }.to change{ LineItem.count }.to(0)
    end
  end

  describe 'role on customer balance' do
    let(:customer) { create(:customer) }
    let(:item) { build(:coat) }
    let(:sale) { build(:sale, customer: customer, line_items: [item]) }

    it 'updates customer balance' do
      expect{ sale.save }.to change{ customer.balance }
    end
  end
end
