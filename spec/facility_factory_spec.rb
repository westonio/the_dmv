require 'spec_helper'

RSpec.describe FacilityFactory do
  it 'exists' do
    factory = FacilityFactory.new

    expect(factory).to be_an_instance_of(FacilityFactory)
  end

  describe 'OR methods' do
    it 'has an OR data parser' do
      factory = FacilityFactory.new
      or_locations = DmvDataService.new.or_dmv_office_locations
      
      parsed_data = factory.or_data_parser(or_locations)

      expect(parsed_data[0]).to be_a(Hash)
      expect(parsed_data).to be_an(Array)
      expect(parsed_data[0].keys).to eq([:name,:address,:phone])
    end

    it 'can create OR facilities' do
      factory = FacilityFactory.new
      or_locations = DmvDataService.new.or_dmv_office_locations

      or_facilities = factory.create_or_facilities(or_locations)
      expect(or_facilities).to be_an(Array)
      expect(or_facilities).to_not be([]) # not empty
      expect(or_facilities[0]).to be_a(Facility)
    end
  end

  describe 'NY methods' do
    it 'Can Titleize Strings' do
      factory = FacilityFactory.new
      string = "1234 west COLORADO blvd., denver, cOlOrAdO"
      expect(factory.titleize(string)).to eq('1234 West Colorado Blvd., Denver, Colorado')
    end
    
    it 'can parse the ny address data into one string' do
      factory = FacilityFactory.new
      facility_details = {:street_address_line_1=>"168 91ST AVE.", :city=>"JAMAICA", :state=>"NY", :zip_code=>"11432"}
      
      parsed_data = factory.ny_address_parser(facility_details)
      expect(parsed_data).to be_a(String)
      expect(parsed_data).to eq("168 91st Ave. Jamaica NY 11432")
    end

    it 'has an NY data parser' do
      factory = FacilityFactory.new
      new_york_locations = DmvDataService.new.ny_dmv_office_locations
      parsed_data = factory.ny_data_parser(new_york_locations)

      expect(parsed_data[0]).to be_a(Hash)
      expect(parsed_data).to be_an(Array)
      expect(parsed_data[0].keys).to eq([:name,:address,:phone])
    end

    it 'can create ny facilities' do
      factory = FacilityFactory.new
      new_york_locations = DmvDataService.new.ny_dmv_office_locations

      new_york_facilities = factory.create_ny_facilities(new_york_locations)
      expect(new_york_facilities).to be_an(Array)
      expect(new_york_facilities).to_not be([]) # not empty
      expect(new_york_facilities[0]).to be_a(Facility)
    end
  end
end