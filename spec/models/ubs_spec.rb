require 'rails_helper'

RSpec.describe Ubs, type: :model do
  it { should belong_to(:address) }
  it { should belong_to(:score).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:score) }
end
