require 'spec_helper'

RSpec.describe Registrant do
  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true)
    @registrant_2 = Registrant.new('Penny', 15)
  end

  it 'exists' do
    expect(@registrant_1).to be_an_instance_of(Registrant)
  end

  it 'has a name' do
    expect(@registrant_1.name).to eq('Bruce')
  end

  it'has an age' do
    expect(@registrant_1.age).to eq(18)
  end

  it 'has default permit value false' do
    expect(@registrant_2.permit?).to eq(false)
  end

  it 'it can also have permit value true' do
    expect(@registrant_1.permit?).to eq(true)
  end

  it 'has default license data' do
    expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    expect(@registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
  end

  it 'has .earn_permit method' do
    @registrant_2.earn_permit
    expect(@registrant_2.permit?).to eq(true)
  end
end