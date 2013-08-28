require 'spec_helper'

describe 'Account Settings API' do
  let(:user) { create(:user) }
  let(:token) { user.authentication_token }
  let(:settings) { user.account_setting }

  describe 'SHOW' do
    context 'settings belongs to token owner' do
      it 'retrieves a specific settings' do
        get "/v1/my/settings", token: token, format: :json

        expect( response ).to be_success
        expect( json['store_name'] ).to eq( settings.store_name )
      end
    end

    # context 'settings does not belong to token owner' do
    #   it 'returns an authorization error' do
    #     get "/v1/settingss/#{settings.id}", token: invalid_token, format: :json
    #     expect( response.status ).to eq 403
    #     expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
    #     expect( json['kind'] ).to eq( 'Authorization Error.' )
    #   end
    # end
  end
end