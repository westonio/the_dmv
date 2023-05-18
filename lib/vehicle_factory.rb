require 'spec_helper'
require 'pry'
class VehicleFactory

  def initialize
    @vehicles = []
  end

  def create_vehicles(vehicle_dataset)
    vehicle_dataset.map do |vehicle_details|
      parsed_data = {vin: vehicle_details[:vin_1_10],
      year: vehicle_details[:model_year],
      make: vehicle_details[:make],
      model: vehicle_details[:model],
      engine: :ev}

      @vehicles << Vehicle.new(parsed_data)
    end
  end
end