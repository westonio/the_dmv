class FacilityFactory
  # This is a helper method for address_parser 
  def or_address_parser(facility)
    JSON.parse(facility[:location_1][:human_address]).values.join(" ")
  end
  
  # This is a helper method for address_parser
  def ny_address_parser(facility)
    [titleize(facility[:street_address_line_1]),
    facility[:street_address_line_2],
    titleize(facility[:city]),
    facility[:state], facility[:zip_code]
    ].compact.join(" ")
  end
  
  # This is a helper method for address_parser
  def mo_address_parser(facility)
    [titleize(facility[:address1]),
    facility[:address2],
    titleize(facility[:city]),
    facility[:state],
    facility[:zipcode]
  ].compact.join(" ")
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

  def create_facilities(facility_dataset)
    facilities = parse_data(facility_dataset)
    facilities.map do |facility|
      Facility.new(facility)
    end
  end

# This method is used after creating facilities
  def add_to_dmv(created_facilities, dmv_name)
    created_facilities.map do |facility|
      dmv_name.add_facility(facility)
    end
  end
end