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

  def register_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
      @registered_vehicles << vehicle
      charge_fee(vehicle) #uses the charge_fee method
      vehicle.register_date # reaches through to the register_date method
    else
      "Error: Vehicle Registration is not enabled for this facility"
    end
  end
end
