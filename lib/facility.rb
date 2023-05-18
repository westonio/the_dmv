class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles

  def initialize(name:, address:, phone:)
    @name = name
    @address = address
    @phone = phone
    @services = []
    @collected_fees = 0
    @registered_vehicles = []
  end

  def add_service(service)
    @services << service
  end

  def charge_fee(vehicle) # This is a helper method for .register_vehicle
    if vehicle.electric_vehicle? 
      @collected_fees += 200 
    elsif vehicle.antique? 
      @collected_fees += 25
    else
      @collected_fees += 100
    end
  end

  def add_plate(vehicle)
    if vehicle.electric_vehicle? 
      vehicle.register_plate(:ev)
    elsif vehicle.antique? 
      vehicle.register_plate(:antique)
    else
      vehicle.register_plate(:regular)
    end
  end

  def register_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
      @registered_vehicles << vehicle
      vehicle.register_date # reaches through to the register_date method
      charge_fee(vehicle) # uses the charge_fee method above
      add_plate(vehicle) # uses the add_plate method above
    else
      "Error: Vehicle Registration is not enabled for this facility"
    end
  end

  def administer_written_test(registrant)
    if @services.include?('Written Test') && registrant.age >= 16 && registrant.permit?
      registrant.license_data[:written] = true
    else
      registrant.license_data[:written]
    end
  end

  def administer_road_test(registrant)
    if @services.include?('Road Test') && registrant.license_data[:written] == true
      registrant.license_data[:license] = true
    else
      registrant.license_data[:license]
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?('Renew License') && registrant.license_data[:license] == true
      registrant.license_data[:renewed] = true
    else
      registrant.license_data[:renewed]
    end
  end
end
