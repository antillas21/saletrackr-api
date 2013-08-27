require 'spec_helper'

describe 'Customer API' do
  let(:user) { create(:user) }
  let(:token) { user.authentication_token }
  let(:other) { create(:user) }
  let(:invalid_token) { other.authentication_token }
  let(:customer) { create(:customer, user: user) }

  describe 'INDEX' do
    context 'with a valid token' do
      it 'gets a list of all customers for token owner' do
        2.times { create(:customer, user: user) }

        get '/v1/customers', token: token, format: :json

        expect( response ).to be_success
        expect( json.length ).to eq(2)
      end
    end

    context 'with invalid or missing token' do
      it 'returns an error when token is missing' do
        get '/v1/customers', token: nil, format: :json
        expect(response.status).to eq 401
        expect( json['error'] ).to eq( 'Authentication Token missing. You must provide an authentication token in your request.' )
        expect( json['kind'] ).to eq('Authentication Error.')
      end

      it 'returns an error with invalid token' do
        get '/v1/customers', token: 'r4nd0mInval1dTok3n', format: :json
        expect(response.status).to eq 401
        expect( json['error'] ).to eq( 'Authentication Token invalid. You must provide a valid authentication token in your request.' )
        expect( json['kind'] ).to eq('Authentication Error.')
      end
    end
  end

  describe 'SHOW' do
    context 'customer belongs to token owner' do
      it 'retrieves a specific customer' do
        get "/v1/customers/#{customer.id}", token: token, format: :json

        expect( response ).to be_success
        expect( json['name'] ).to eq( customer.name )
      end
    end

    context 'customer does not belong to token owner' do
      it 'returns an authorization error' do
        get "/v1/customers/#{customer.id}", token: invalid_token, format: :json
        expect( response.status ).to eq 403
        expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
        expect( json['kind'] ).to eq( 'Authorization Error.' )
      end
    end

    context 'customer does not exist in database' do
      it 'returns a resource not found error' do
        get '/v1/customers/invalid', token: token, format: :json
        expect( response.status ).to eq(404)
        expect( json['error'] ).to eq( 'Resource Not Found Error. The resource you requested could not be found. It may been removed or you may be using a wrong ID' )
        expect(  json['kind'] ).to eq( 'Resource Not Found Error.' )
      end
    end
  end

  describe 'UPDATE' do
    context 'customer belongs to token owner' do
      describe 'with valid params' do
        it 'completes successfully' do
          put "/v1/customers/#{customer.id}", token: token,
            customer: { name: 'New name' }, format: :json
          expect( response.status ).to eq(204)
          customer.reload
          expect( customer.name ).to eq 'New name'
        end
      end

      describe 'with invalid params' do
        # it 'does not change the resource' do
        #   put "/v1/customers/#{customer.id}", token: token, format: :json
        #   expect( response.status ).to eq(422)
        #   customer.reload
        #   expect( customer.name ).not_to be_nil
        # end
      end
    end

    context 'customer does not belong to token owner' do
      it 'returns an authorization error' do
        put "/v1/customers/#{customer.id}", token: invalid_token,
          customer: { name: 'New name' }, format: :json
        expect( response.status ).to eq 403
        expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
        expect( json['kind'] ).to eq( 'Authorization Error.' )
      end
    end
  end

  describe 'DESTROY' do
    context 'customer belongs to token owner' do
      it 'deletes resource from database' do
        delete "/v1/customers/#{customer.id}", token: token, format: :json
        expect( response.status ).to eq 200
      end
    end

    context 'customer does not belong to token owner' do
      it 'returns an authorization error' do
        delete "/v1/customers/#{customer.id}", token: invalid_token, format: :json
        expect( response.status ).to eq 403
        expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
        expect( json['kind'] ).to eq( 'Authorization Error.' )
      end
    end
  end
end