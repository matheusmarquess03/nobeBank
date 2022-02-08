require 'rails_helper'

describe User do
  describe 'Validates' do
    let!(:user) { create :user }

    context 'parameters cannot be empty' do
      it { expect(user).to be_valid }
    end

    context 'has a unique user email' do
      it { expect(user).to be_valid }
    end

    context "when user is created" do
      it "is created an account" do
        expect(user.account).not_to be_nil
      end
    end

    it "has a unique user email" do
      user = build(:user, email: "n@nobe.com.br")
      expect(user).to be_valid
    end

    it "is not valid without a password" do 
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end
end
