class FacilityFactory
  # This is a helper method for address_parser 
  def or_address_parser(facility)
    address_parsed = JSON.parse(facility[:location_1][:human_address])
    address_parsed.values.join(" ")
  end
  
  # This is a helper method for address_parser
  def ny_address_parser(facility_details)
    address_parsed = ""
    address_parsed += "#{titleize(facility_details[:street_address_line_1])}"
    address_parsed += " #{titleize(facility_details[:city])}"
    address_parsed += " #{facility_details[:state]}"
    address_parsed += " #{facility_details[:zip_code]}"
  end
  
  # This is a helper method for address_parser
  def mo_address_parser(facility_details)
    address_parsed = ""
    address_parsed += "#{titleize(facility_details[:address1])}"
    address_parsed += " #{titleize(facility_details[:city])}"
    address_parsed += " #{facility_details[:state]}"
    address_parsed += " #{facility_details[:zipcode]}"
  end
  
  # This is a helper function to capitalize the first character of each word
  def titleize(string)
    string.split(' ').map(&:capitalize).join(" ")
  end
  
  def address_parser(facility)
    if facility.has_key?(:location_1)
      or_address_parser(facility)
    elsif facility.has_key?(:street_address_line_1)
      ny_address_parser(facility)
    elsif facility.has_key?(:address1)
      mo_address_parser(facility)
    end
  end

  def parse_data(facility_dataset)
    facility_dataset.map do |facility|
      name = facility[:title] || facility[:office_name] || facility[:name]
      address = address_parser(facility)
      phone = facility[:phone_number] || facility[:public_phone_number] || facility[:phone]
      
      {name: titleize(name), address: address, phone: phone}
    end
  end
end