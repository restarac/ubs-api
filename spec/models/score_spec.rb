require 'rails_helper'

RSpec.describe Score, type: :model do
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:adaptation_for_seniors) }
  it { should validate_presence_of(:medical_equipment) }
  it { should validate_presence_of(:medicine) }
end
