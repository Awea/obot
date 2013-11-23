module Behaviours
  class MoveMinerals
    class << self
      def move_to_origin
        NAV.ul(id: 'menuTable').element(class: 'menubutton', text: 'Flotte').click
      end

      def proceed(coordinates)
        Interface::RightMenu.switch_planet(coordinates)        
        destination = find_first_unatacked_planet(coordinates)
        move_to_origin

        return false unless big_transports? # Crappy debug

        big_transports_container.link(class: 'tooltip').click # Select all big transport
        NAV.link(id: 'continue').click                    
        sleep(2)

        Interface::InputFleetDestination.set(destination) # Fill destination form
        NAV.link(id: 'continue').click                    
        sleep(2)
        
        NAV.link(id: 'missionButton4').click # Select park order
        NAV.link(id: 'allresources').click   # Take all resources
        NAV.link(id: 'start').click          # Launch fleet
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
end