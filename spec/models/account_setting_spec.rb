require 'spec_helper'

describe AccountSetting do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :language }
    it { should validate_presence_of :store_name }
  end

  describe 'create' do
    it 'is created when a user signs up' do
      user = build(:user)
      expect{ user.save }.to change{ AccountSetting.count }.by(1)
    end

    it 'set to English language when created' do
      user = create(:user)
      acct_settings = user.account_setting

      acct_settings.language.should eq 'en'
    end
  end
end
