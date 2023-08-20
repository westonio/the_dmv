# The DMV

## Project Overview
*The DMV* is a Ruby project I worked on solo that simulates the operations of a Department of Motor Vehicles (DMV). The project involves creating a set of classes that interact to perform various tasks related to vehicle registration, driver's license acquisition, and DMV Facilities. The project also consumes data from various state DMV APIs to create facility and vehicle objects.
<br/> <br/>
This showcases my ability to work with an existing codebase, apply object-oriented programming principles, and integrate external data to build a comprehensive simulation of DMV operations. The project highlights my proficiency in Test-Driven Development and demonstrates my coding skills in creating interactive and modular Ruby applications.
<br/>

### Languages, Frameworks, and Tools used:
- **Built with:** Ruby
- **Tested with:** RSpec (and Pry for spiking out solutions)
- **Tools / Workflow:** Git, GitHub

---
### Features
- **Registrant Class -** The Registrant class represents individuals interacting with the DMV. Each registrant has attributes such as name, age, permit status, and license data. Here's an example of using the Registrant class.
  ```
  registrant = Registrant.new('Bruce', 18, true)
  
  registrant.name
  #=> "Bruce"
  registrant.age
  #=> 18
  registrant.permit?
  #=> true
  ```
- **Vehicle Class -** The Vehicle class represents vehicles that can be registered at the DMV. Vehicles have attributes such as VIN, year, make, model, and engine type. They can be registered as regular, antique, or electric vehicles.
```
vehicle = Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice })

vehicle.registration_date
#=> nil 
facility.register_vehicle(vehicle)
vehicle.registration_date
#=> #<Date: 2023-01-12 ...>
vehicle.plate_type
#=> :regular
```
- **Facility Class -** The Facility class represents a DMV facility where various services can be performed. Facilities can administer tests, register vehicles, and renew licenses. Services include written tests, road tests, vehicle registration, and license renewal.
```
facility = Facility.new({ name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600' })

facility.add_service('Written Test')
facility.administer_written_test(registrant)
```
- **DmvDataService -** The project also demonstrates reading data from external data sets using the DmvDataService class. This allows creating vehicle and facility objects using parsing the data from different states.

### Challenges
- Integrating external data sets into the project and parsing them to create meaningful objects posed a challenge. Reading data from different formats, handling nested data structures, and mapping the data to appropriate class attributes required careful consideration and implementation. This challenge required a deep understanding of data manipulation and object instantiation.
- The project involved simulating intricate interactions between registrants, vehicles, and facilities. Implementing the logic to ensure that the correct tests were administered, licenses were acquired in the right sequence, and vehicles were registered based on specific criteria was complex. Navigating this web of interactions while maintaining clean, encapsulated, and modular code was a challenge.
- Adapting the code to work with multiple data sources (different states' DMV data) required significant refactoring. Ensuring that the existing code continued to work seamlessly while integrating new data sources without introducing errors or breaking existing functionality was a challenge. This task demanded a balance between maintaining backward compatibility and introducing new features.

### Accomplishments
- Successfully improved an existing codebase by addressing pre-existing bugs and errors. Through careful debugging and refactoring, I resolved issues and gained practical experience in navigating and understanding unfamiliar codebases.
- Demonstrated strong object-oriented programming skills by creating well-structured classes that represent different entities and interactions within a DMV facility. This approach allowed for easy extensibility and maintenance of the code.
- Employed Test-Driven Development (TDD) to design and implement new features. By writing tests first and then building code to pass those tests, I ensured that the code met the expected behavior and improved its reliability, maintainability, and robustness.
- Successfully integrated external data sets from various DMV facilities and vehicle registrations into the project. This achievement showcases my ability to work with real-world data and demonstrates the project's potential for handling diverse data sources.

---

## Setup 
For more details, feel free to explore the code and run the provided tests.
1. **Clone the Repository:** Begin by cloning this repository to your local machine using the following command:
`git clone git@github.com:westonio/the_dmv.git`
2. **Navigate to Project Directory:** Move into the project directory:
`cd the_dmv`
3. **Run the Tests:** To run the entire test suite, use the following command: `rspec spec`
> *Please note: This project consumes data from an API - This means data may change and could potentially lead to a few failing tests (such as number of DMV facilities expected to be received through the API).*
