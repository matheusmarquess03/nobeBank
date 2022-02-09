require 'rails_helper'

describe Transfer do
  context 'Validates' do
    let!(:transfer) { create :transfer }

    context 'parameters cannot be empty' do
      it { expect(transfer).to be_valid }
    end
  end
end

