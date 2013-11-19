module Behaviours
  module MoveMinerals
    def move_to_origin
      NAV.ul(id: 'menuTable').element(class: 'menubutton', text: 'Flotte').click
    end
    module_function :move_to_origin

    # origin coordinates c:o:d
    def proceed(origin)
      Interface::Menu.switch_planet(origin)
      
      origin      = Planets.find_by_coordinates(origin)
      destination = Planets.find_first_unatacked_planet(origin)
      # Go in fleet
      move_to_origin

      return false unless big_transports? # Crappy debug

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
    end
    module_function :proceed

    def big_transports?
       big_transports_container.exist?
    end
    module_function :big_transports?

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