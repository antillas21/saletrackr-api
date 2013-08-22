require 'spec_helper'

describe Transaction do

  describe 'relationships' do
    it { should belong_to :customer }
  end

  describe 'validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :customer_id }
  end

end
