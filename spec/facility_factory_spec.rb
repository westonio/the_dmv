require 'spec_helper'

RSpec.describe FacilityFactory do
  it 'exists' do
    factory = FacilityFactory.new

    expect(factory).to be_an_instance_of(FacilityFactory)
  end

  it 'can create OR facilities' do
    factory = FacilityFactory.new
    or_dmv_office_locations = DmvDataService.new.or_dmv_office_locations

    or_facilities = factory.create_facilities(or_dmv_office_locations)
    expect(or_facilities).to be_an(Array)
    expect(or_facilities).to_not be([]) # not empty
    require 'pry'; binding.pry
  end
end