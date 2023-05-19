class FacilityFactory

  def or_data_parser(facility_dataset)
    facility_dataset.map do |facility_details|
      address_parsed = JSON.parse(facility_details[:location_1][:human_address])
      {
        name: facility_details[:title],
        address:address_parsed.values.join(" "),
        phone: facility_details[:phone_number]
      }
    end
  end

  def create_or_facilities(facility_dataset)
    or_data = or_data_parser(facility_dataset) # Calling the or_data_parser helper method
  # iterate through each parsed data to create new facility
    or_data.map do |facility|
      Facility.new(facility)
    end
  end

  # This is a helper method for ny_address_parser
    def ny_address_parser(facility_details)
        address_parsed = ""
        address_parsed += "#{titleize(facility_details[:street_address_line_1])}"
        address_parsed += " #{titleize(facility_details[:city])}"
        address_parsed += " #{facility_details[:state]}"
        address_parsed += " #{facility_details[:zip_code]}"
    end
  
  # This is a helper function to capitalize the first character of each word
    def titleize(string)
      string.split(' ').map(&:capitalize).join(" ")
    end
  
  # def create_facilities(facility_dataset)
  #   if defined? facility_dataset.to_s.include?("or_")
  #     create_or_facilities(facility_dataset)
  #   end
  # end
end