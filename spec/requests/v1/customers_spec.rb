require 'spec_helper'

describe 'Customer API' do
  let(:user) { create(:user) }
  let(:token) { user.authentication_token }

  it 'gets a list of all customers' do
    2.times { create(:customer, user: user) }

    get '/v1/customers', token: token, format: :json

    expect( response ).to be_success
    expect( json.length ).to eq(2)
  end

  it 'retrieves a specific customer' do
    customer = FactoryGirl.create(:customer, user: user)

    get "/v1/customers/#{customer.id}", token: token, format: :json

    expect( response ).to be_success
    expect( json['name'] ).to eq( customer.name )
  end
end