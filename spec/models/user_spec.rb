require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }
  
  # Association test
  it { should have_many(:tweeets) }
  it { should belong_to(:organization) }
 
  describe "public instance methods" do
    context "responds to its methods" do
      it { expect(user).to respond_to(:generate_password_token) }
      it { expect(user).to respond_to(:password_token_valid?) }
      it { expect(user).to respond_to(:reset_password!) }
      it { expect(user).to respond_to(:generate_jwt) }
    end
  end

end
