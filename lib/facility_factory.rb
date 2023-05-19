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

  def create_facilities(facility_dataset)
    if defined? facility_dataset.to_s.include?("or")
      or_data = or_data_parser(facility_dataset)
      or_data.map do |facility|
        Facility.new(facility)
      end
    end
  end
end