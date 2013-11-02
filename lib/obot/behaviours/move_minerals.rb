module Behaviours
  module MoveMinerals
    def move_to_origin
      NAV.ul(id: 'menuTable').element(class: 'menubutton', text: 'Flotte').click
    end
    module_function :move_to_origin

    def ready_to_proceed
      # Grab all planets coordinates and store them
      planets = NAV.spans(class: 'planet-koords').map{ |coordinates|
                    coordinates.when_present.text
                  }
      puts planets.inspect
      Planets.store_scraped_planets(planets) 

      # For each planets get the current fleet
      Planets.all.each do |planet|
        Interface::Menu.switch_planet(planet[:coordinates])
        move_to_origin
        big_transports = big_transports? ? count_big_transports : 0
        LargeCarrierFleet.new(planet[:id], big_transports).save
      end
    end
    module_function :ready_to_proceed

    def ready?(origin)
      persisted_big_transports?(origin)
    end
    module_function :ready?

    # origin is a [c:o:d]
    # destination is an array from Planets class :s
    def proceed(origin)
      return false unless ready?(origin)
      Interface::Menu.switch_planet(origin)
      
      origin      = Planets.find_by_coordinates(origin)
      destination = Planets.find_first_unatacked_planet(origin)
      # Go in fleet
      move_to_origin
      # Select all big transport
      big_transports_container.link(class: 'tooltip').click
      # Next fleet page
      NAV.link(id: 'continue').click
      sleep(2)
      # Fill destination form
      splitted_destination = destination[:coordinates].split(':')
      NAV.text_field(id: 'galaxy').set(splitted_destination[0])
      NAV.text_field(id: 'system').set(splitted_destination[1])
      NAV.text_field(id: 'position').set(splitted_destination[2])
      # Next fleet page
      NAV.link(id: 'continue').click
      sleep(2)
      # Select park order
      puts NAV.link(id: 'missionButton4').click
      # Take all resources
      NAV.link(id: 'allresources').click
      # Launch fleet
      NAV.link(id: 'start').click
    
      LargeCarrierFleets.transfert(origin[:id], destination[:id])
    end
    module_function :proceed

    def big_transports?
       big_transports_container.exist?
    end
    module_function :big_transports?

    def persisted_big_transports?(coordinates)
      planet = Planets.find_by_coordinates(coordinates)
      LargeCarrierFleets.available_by_planet(planet[:id]) > 0
    end
    module_function :persisted_big_transports?

    def count_big_transports
      sleep(2)
      big_transports_container.when_present.link.text
    end
    module_function :count_big_transports

    def big_transports_container
      NAV.li(id: 'button203').div(class: 'buildingimg')
    end
    module_function :big_transports_container
  end
end