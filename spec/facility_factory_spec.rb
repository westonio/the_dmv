require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
    @factory = FacilityFactory.new
    @or_locations = DmvDataService.new.or_dmv_office_locations
    @ny_locations = DmvDataService.new.ny_dmv_office_locations
    @mo_locations = DmvDataService.new.mo_dmv_office_locations
  end

  describe 'initialize' do
    it 'exists' do
      expect(@factory).to be_an_instance_of(FacilityFactory)
    end
  end

  describe 'address parsers' do
    it 'has OR address parser' do
      facility_details = {:location_1=>
      {:latitude=>"42.184549",
      :longitude=>"-122.671018",
      :human_address=>"{\"address\": \"600 Tolman Creek Rd\", \"city\": \"Ashland\", \"state\": \"OR\", \"zip\": \"97520\"}"}}
      
      expect(@factory.or_address_parser(facility_details)).to eq("600 Tolman Creek Rd Ashland OR 97520")
    end

    it 'has NY address parser' do
      facility_details = {:street_address_line_1=>"168 91ST AVE.", :city=>"JAMAICA", :state=>"NY", :zip_code=>"11432"}
      
      parsed_data = @factory.ny_address_parser(facility_details)

      expect(parsed_data).to be_a(String)
      expect(parsed_data).to eq("168 91st Ave. Jamaica NY 11432")
    end

    it 'has MO address parser' do
      facility_details = {:address1=>"10425 WEST FLORISSANT", :city=>"FERGUSON", :state=>"MO", :zipcode=>"63136"}
      
      parsed_data = @factory.mo_address_parser(facility_details)

      expect(parsed_data).to be_a(String)
      expect(parsed_data).to eq("10425 West Florissant Ferguson MO 63136")
    end

    it 'can parse address based off state' do
      oregon = @factory.address_parser(@or_locations[0])
      new_york = @factory.address_parser(@ny_locations[0])
      missouri = @factory.address_parser(@mo_locations[0])

      expect(oregon).to be_a(String)
      expect(new_york).to be_a(String)
      expect(missouri).to be_a(String)
    end
  end

  describe '#parse_data' do
    it 'can parse all OR data into name, address, phone format' do
      parsed = @factory.parse_data(@or_locations)
      
      expect(parsed).to be_a(Array)
      expect(parsed[0].keys).to eq([:name, :address, :phone])
    end
    
    it 'can parse all NY data into name, address, phone format' do
      parsed = @factory.parse_data(@ny_locations)
      
      expect(parsed).to be_a(Array)
      expect(parsed[0].keys).to eq([:name, :address, :phone])
    end

    it 'can parse all MO data into name, address, phone format' do
      parsed = @factory.parse_data(@mo_locations)
      
      expect(parsed).to be_a(Array)
      expect(parsed[0].keys).to eq([:name, :address, :phone])
    end
  end

  describe '#titleize' do
    it 'can return string with first letter of each word capitalized' do
      string = "1234 west COLORADO blvd., denver, cOlOrAdO"
      expect(@factory.titleize(string)).to eq('1234 West Colorado Blvd., Denver, Colorado')
    end
  end

  describe '#create_facilities' do
    it 'can create OR facilities' do
      or_facilities = @factory.create_facilities(@or_locations)
      
      expect(or_facilities[0]).to be_a(Facility)
      expect(or_facilities).to be_an(Array)
    # the following assertion is subject to fail if any hard data changes (pulled from api source)
      expect(or_facilities.first.name).to eq("Albany Dmv Office")
    end

    it 'can create NY facilities' do
      ny_facilities = @factory.create_facilities(@ny_locations)
      
      expect(ny_facilities[0]).to be_a(Facility)
      expect(ny_facilities).to be_an(Array)
    # the following assertion is subject to fail if any hard data changes (pulled from api source)
      expect(ny_facilities.first.name).to eq("Jamaica Kiosk")
    end

    it 'can create MO facilities' do
      mo_facilities = @factory.create_facilities(@mo_locations)
      
      expect(mo_facilities[0]).to be_a(Facility)
      expect(mo_facilities).to be_an(Array)
    # the following assertion is subject to fail if any hard data changes (pulled from api source)
      expect(mo_facilities.first.name).to eq("Oakville")
    end
  end

  describe '#add_to_dmv' do
    it 'can add facilities to the OR dmv' do
      or_facilities = @factory.create_facilities(@or_locations)
      or_dmv = Dmv.new
      
      @factory.add_to_dmv(or_facilities, or_dmv)
      
      expect(or_dmv.facilities.length).to eq(or_facilities.length)
      expect(or_dmv.facilities).not_to be([])
      expect(or_dmv.facilities.first).to be_a(Facility)
    # the following assertion is subject to fail if any hard data changes (pulled from api source)
      expect(or_dmv.facilities.first.name).to eq("Albany Dmv Office")
    end

    it 'can add facilities to the NY dmv' do
      ny_facilities = @factory.create_facilities(@ny_locations)
      ny_dmv = Dmv.new
      
      @factory.add_to_dmv(ny_facilities, ny_dmv)
      
      expect(ny_dmv.facilities.length).to eq(ny_facilities.length)
      expect(ny_dmv.facilities).not_to be([])
      expect(ny_dmv.facilities.first).to be_a(Facility)
    # the following assertion is subject to fail if any hard data changes (pulled from api source)
      expect(ny_dmv.facilities.first.name).to eq("Jamaica Kiosk")
    end

    it 'can add facilities to the MO dmv' do
      mo_facilities = @factory.create_facilities(@mo_locations)
      mo_dmv = Dmv.new
      
      @factory.add_to_dmv(mo_facilities, mo_dmv)
      
      expect(mo_dmv.facilities.length).to eq(mo_facilities.length)
      expect(mo_dmv.facilities).not_to be([])
      expect(mo_dmv.facilities.first).to be_a(Facility)
    # the following assertion is subject to fail if any hard data changes (pulled from api source)
      expect(mo_dmv.facilities.first.name).to eq("Oakville")
    end
  end
end