require 'rails_helper'

RSpec.describe Tweeet, type: :model do

  let(:tweeet) { build(:tweeet) }
  
  # Association test
  it { should belong_to(:user) }
 
  describe "public instance methods" do
    context "responds to its methods" do
      it { expect(tweeet).to respond_to(:is_owner) }
    end
  end

end
