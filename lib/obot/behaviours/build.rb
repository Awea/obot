module Behaviours
  class Build
    class << self
      def find_interface_link(order_interface)
        if order_interface == 'in'
          'Installations'
        else
          'Ressources'
        end
      end

      def move_to_origin(text_link)
        #NAV.ul(id: 'menuTable').element(class: 'menubutton', text: 'Ressources').click
        NAV.ul(id: 'menuTable').element(class: 'menubutton', text: text_link).click
      end

      def proceed
        orders = BuildLoops.all # Get all build to do

        orders.each do |order|
          Interface::Menu.switch_planet(order.planet_coordinates)
          move_to_origin(find_interface_link(order.interface))
          Interface::Building.new(order).click
        end
      end
    end
  end
end