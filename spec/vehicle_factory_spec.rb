require 'spec_helper'

RSpec.describe VehicleFactory do
  it 'exists' do
    factory = VehicleFactory.new

    expect(factory).to be_an_instance_of(VehicleFactory)
  end

  it 'can create vehicles from datasets' do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations

    added_vehicles = factory.create_vehicles(wa_ev_registrations)
    expect(added_vehicles).to be_an(Array)
    expect(added_vehicles).to_not be([]) # not empty
    expect(added_vehicles.first).to be_an(Vehicle)
  end
end