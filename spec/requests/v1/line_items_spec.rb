require 'spec_helper'

describe 'LineItems API' do
  let(:user) { create(:user) }
  let(:token) { user.authentication_token }
  let(:customer) { create(:customer, user: user) }
  let(:customer_b) { create(:customer, user: user) }
  let(:sale) { create(:sale, customer: customer) }
  let!(:line_item) { create(:coat, sale: sale) }
  let(:user_b) { create(:user) }
  let(:token_b) { user_b.authentication_token }

  describe 'INDEX' do
    context 'with a valid token' do
      it 'gets a list of all line_items for token owner' do
        get '/v1/line-items', token: token, format: :json

        expect( response ).to be_success
        expect( json.length ).to eq(1)
      end
    end

    context 'with invalid or missing token' do
      it 'returns an error when token is missing' do
        get '/v1/line-items', token: nil, format: :json
        expect(response.status).to eq 401
        expect( json['error'] ).to eq( 'Authentication Token missing. You must provide an authentication token in your request.' )
        expect( json['kind'] ).to eq('Authentication Error.')
      end

      it 'returns an error with invalid token' do
        get '/v1/line-items', token: 'r4nd0mInval1dTok3n', format: :json
        expect(response.status).to eq 401
        expect( json['error'] ).to eq( 'Authentication Token invalid. You must provide a valid authentication token in your request.' )
        expect( json['kind'] ).to eq('Authentication Error.')
      end
    end
  end

  describe 'SHOW' do
    context 'line_item belongs to token owner' do
      it 'retrieves a specific line_item' do
        get "/v1/line-items/#{line_item.id}", token: token, format: :json

        expect( response ).to be_success
        expect( json['name'] ).to eq( line_item.name )
      end
    end

    context 'line_item does not belong to token owner' do
      it 'returns an authorization error' do
        get "/v1/line-items/#{line_item.id}", token: token_b, format: :json
        expect( response.status ).to eq 403
        expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
        expect( json['kind'] ).to eq( 'Authorization Error.' )
      end
    end

    context 'line_item does not exist in database' do
      it 'returns a resource not found error' do
        get '/v1/line-items/invalid', token: token, format: :json
        expect( response.status ).to eq(404)
        expect( json['error'] ).to eq( 'Resource Not Found Error. The resource you requested could not be found. It may been removed or you may be using a wrong ID' )
        expect(  json['kind'] ).to eq( 'Resource Not Found Error.' )
      end
    end
  end

  describe 'UPDATE' do
    context 'line_item belongs to token owner' do
      describe 'with valid params' do
        it 'completes successfully' do
          put "/v1/line-items/#{line_item.id}", token: token,
            line_item: { name: 'New name' }, format: :json
          expect( response.status ).to eq(204)
          line_item.reload
          expect( line_item.name ).to eq 'New name'
        end
      end

      describe 'with invalid params' do
        # it 'does not change the resource' do
        #   put "/v1/line-items/#{line_item.id}", token: token, format: :json
        #   expect( response.status ).to eq(422)
        #   line_item.reload
        #   expect( line_item.name ).not_to be_nil
        # end
      end
    end

    context 'line_item does not belong to token owner' do
      it 'returns an authorization error' do
        put "/v1/line-items/#{line_item.id}", token: token_b,
          line_item: { amount: 50000 }, format: :json
        expect( response.status ).to eq 403
        expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
        expect( json['kind'] ).to eq( 'Authorization Error.' )
      end
    end
  end

  describe 'DELETE' do
    context 'line_item belongs to token owner' do
      it 'deletes resource from database' do
        delete "/v1/line-items/#{line_item.id}", token: token, format: :json
        expect( response.status ).to eq 200
      end
    end

    context 'line_item does not belong to token owner' do
      it 'returns an authorization error' do
        delete "/v1/line-items/#{line_item.id}", token: token_b, format: :json
        expect( response.status ).to eq 403
        expect( json['error'] ).to eq( 'Authorization Failure. You do not have permission to access the resource you requested.' )
        expect( json['kind'] ).to eq( 'Authorization Error.' )
      end
    end
  end
end