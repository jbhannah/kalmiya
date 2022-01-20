# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    subject { response }

    before { get '/' }

    context 'without a current session' do
      it { is_expected.to have_http_status(:redirect) }
    end
  end
end
