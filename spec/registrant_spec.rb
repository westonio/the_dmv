require 'spec_helper'

RSpec.describe Registrant do
  it 'exists' do
    registrant_1 = Registrant.new('Bruce', 18, true)

    expect(registrant_1).to be_an_instance_of(Registrant)
  end

  it 'has a name' do
    registrant_1 = Registrant.new('Bruce', 18, true)

    expect(registrant_1.name).to eq('Bruce')
  end

  it'has an age' do
    registrant_1 = Registrant.new('Bruce', 18, true)

    expect(registrant_1.age).to eq(18)
  end
end