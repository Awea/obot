module Behaviours
  class MoveMinerals
    def move_to_origin
      NAV.ul(id: 'menuTable').element(class: 'menubutton', text: 'Flotte').click
    end

    # origin coordinates c:o:d
    def proceed(origin)
      Interface::Menu.switch_planet(origin)
      
      destination = find_first_unatacked_planet(origin)
      move_to_origin

      return false unless big_transports? # Crappy debug

      # Select all big transport
      big_transports_container.link(class: 'tooltip').click
      # Next fleet page
      NAV.link(id: 'continue').click
      sleep(2)
      # Fill destination form
      splitted_destination = destination.split(':')
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

    private

    def big_transports_container
      NAV.li(id: 'button203').div(class: 'buildingimg')
    end

    def big_transports?
       big_transports_container.exist?
    end

    def find_first_unatacked_planet(attacked_coordinates)
      NAV.spans(class: 'planet-koords').map{ |coordinates|
        coordinates.when_present.text
      }.select { |coordinates| 
        coordinates != attacked_coordinates 
      }.first
    end
  end
end