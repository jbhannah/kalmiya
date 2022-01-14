# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/user/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /' do
    context 'with valid parameters' do
      subject { response }

      let(:user) { build(:user) }

      before { post '/user', params: { user: { email: user.email, password: user.password } } }

      it { is_expected.to redirect_to(root_url) }

      it 'creates a user' do
        expect(User.where(email: user.email).count).to be 1
      end
    end
  end
end
