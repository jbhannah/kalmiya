# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /new' do
    subject { response }

    before { get '/sessions/new' }

    it { is_expected.to have_http_status(:success) }
  end

  describe 'POST /' do
    subject { response }

    let(:user) { create(:user) }

    context 'with valid parameters' do
      before { post '/sessions', params: { user: { email: user.email, password: user.password } } }

      it { is_expected.to redirect_to(root_url) }

      it 'creates a session' do
        expect(User.find_by(email: user.email).sessions.count).to be 1
      end
    end
  end
end
