require 'spec_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
  end

  describe 'relationships' do
    it { should have_many :customers }
    it { should have_one :account_setting }
  end
end
