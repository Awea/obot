module Behaviours
  class Build
    class << self
      def cli_interface_to_nav_link(cli_interface)
        if cli_interface == 'in'
          'Installations'
        elsif ['re', 'su'].include?(cli_interface)
          'Ressources'
        elsif cli_interface == 'sc'
          # 'Recherche'
          # We need another build management construction
          # Need to handle all li and ul whatever construct / search / production it is
          # Try to write spec about it ?
          raise NotImplementedError
        end
      end

      def move_to_origin(text_link)
        NAV.ul(id: 'menuTable').element(class: 'menubutton', text: text_link).click
      end

      def proceed
        orders = BuildLoops.all # Get all build to do

        orders.each do |order|
          Interface::Menu.switch_planet(order.planet_coordinates)
          move_to_origin(cli_interface_to_nav_link(order.interface))
          Interface::Building.new(order).click
        end
      end
    end
  end
end