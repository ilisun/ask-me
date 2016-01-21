require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    it_behaves_like "API Authenticable"

    def do_request(options = {})
      get '/api/v1/profiles/me', { format: :json }.merge(options)
    end
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    %w(id email).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
      end
    end

    %w(password encrypted_password).each do |attr|
      it "does not contain #{attr}" do
        expect(response.body).to_not have_json_path(attr)
      end
    end
  end
end