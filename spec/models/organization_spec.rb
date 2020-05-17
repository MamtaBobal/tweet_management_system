require 'rails_helper'

RSpec.describe Organization, type: :model do

  let(:organization) { build(:organization) }
  
  # Association test
  it { should have_many(:users) }

  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
