class FacilityFactory
  def or_address_parser(facility)
    address_parsed = JSON.parse(facility[:location_1][:human_address])
    address_parsed.values.join(" ")
  end
  
  def ny_address_parser(facility_details)
    address_parsed = ""
    address_parsed += "#{titleize(facility_details[:street_address_line_1])}"
    address_parsed += " #{titleize(facility_details[:city])}"
    address_parsed += " #{facility_details[:state]}"
    address_parsed += " #{facility_details[:zip_code]}"
  end
  
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
end