# frozen_string_literal: true

require 'rails_helper'

describe Account do
  context 'Validates' do
    let!(:account) { create :account }

    context 'parameters cannot be empty' do
      it { expect(account).to be_valid }
    end
  end
end
