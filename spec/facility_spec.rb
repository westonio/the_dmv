require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('Albany DMV Office')
      expect(@facility.address).to eq('2242 Santiam Hwy SE Albany OR 97321')
      expect(@facility.phone).to eq('541-967-2014')
      expect(@facility.services).to eq([])
      expect(@facility.collected_fees).to eq(0)
      expect(@facility.registered_vehicles).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#charge_fee' do
    it 'can charge 200 for EV' do
      @facility.add_service('Vehicle Registration')
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )

      expect(@facility.charge_fee(bolt)).to eq(200)
    end

    it 'can charge 25 for antique' do
      @facility.add_service('Vehicle Registration')
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      
      expect(@facility.charge_fee(camaro)).to eq(25)
    end

    it 'can charge 100 for all others' do
      @facility.add_service('Vehicle Registration')
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )

      expect(@facility.charge_fee(cruz)).to eq(100)
    end
  end

  describe '#add_plate' do
    it 'can add its plate' do
      @facility.add_service('Vehicle Registration')
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )

      expect(@facility.add_plate(cruz)).to eq(:regular)
      expect(@facility.add_plate(camaro)).to eq(:antique)
      expect(@facility.add_plate(bolt)).to eq(:ev)
    end
  end

  describe '#register_vehicle' do
    it 'can register a vehicle' do
      @facility.add_service('Vehicle Registration')
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      @facility.register_vehicle(camaro)
      expect(@facility.registered_vehicles).to eq([camaro])
    end
    
    it 'gives error if facility does not offer service' do
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      expect(@facility.register_vehicle(camaro)).to eq("Error: Vehicle Registration is not enabled for this facility")
    end

    it 'adds $200 to fees for electric vehicles' do
      @facility.add_service('Vehicle Registration')
      bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
      @facility.register_vehicle(bolt)

      expect(@facility.collected_fees).to eq(200)
    end

    it 'adds $25 to fees for cars over 25 years' do
      @facility.add_service('Vehicle Registration')
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      @facility.register_vehicle(camaro)

      expect(@facility.collected_fees).to eq(25)
    end

    it 'adds $100 to fees for all others' do
      @facility.add_service('Vehicle Registration')
      cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      @facility.register_vehicle(cruz)

      expect(@facility.collected_fees).to eq(100)
    end

    it 'can update the registration date' do
      @facility.add_service('Vehicle Registration')
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      @facility.register_vehicle(camaro)

      expect(camaro.registration_date).to eq(Date.today)
    end

    it 'can update the plate type' do
      @facility.add_service('Vehicle Registration')
      camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice})
      @facility.register_vehicle(camaro)

      expect(camaro.plate_type).to eq(:antique)
    end
  end

  describe 'Getting a drivers license' do
    it 'can administer a written test' do
      registrant_1 = Registrant.new('Bruce', 18, true )
      
      expect(@facility.administer_written_test(registrant_1)).to be(false)

      @facility.add_service('Written Test')
      expect(@facility.administer_written_test(registrant_1)).to be(true)
    end

    it 'cannot administer a test if no permit and under 16' do
      registrant_1 = Registrant.new('Bruce', 18)
      registrant_2 = Registrant.new('Bree', 15, true)
      
      expect(@facility.administer_written_test(registrant_1)).to be(false)

      @facility.add_service('Written Test')
      expect(@facility.administer_written_test(registrant_1)).to be(false)
      expect(@facility.administer_written_test(registrant_2)).to be(false)
    end
  end
end
