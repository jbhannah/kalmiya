# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    context 'without a current session' do
      it 'redirects to the login page' do
        get '/'
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
