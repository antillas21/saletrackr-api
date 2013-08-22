require 'spec_helper'

describe LineItem do
  let(:sale) { create(:sale) }

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :qty }
    it { should validate_presence_of :price }
  end

  describe 'relationships' do
    it { should belong_to :sale }
  end

  describe 'item_sale_total' do
    it 'is auto-calculated' do
      item = FactoryGirl.create(:coat, qty: 3, price: 900.0, sale_id: sale.id)
      item.item_sale_total.should == 2700.0
    end
  end

  describe 'item_cost_total' do
    it 'is auto-calculated' do
      item = FactoryGirl.create(:coat, qty: 3, price: 900.0, cost: 600, sale_id: sale.id)
      item.item_cost_total.should == 1800.0
    end
  end
end
