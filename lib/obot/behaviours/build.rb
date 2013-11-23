module Behaviours
  class Build
    class << self
      def cli_interface_to_nav_link(cli_interface)
        if cli_interface == 'in'
          Interface::LeftMenu.installations
        elsif ['re', 'su'].include?(cli_interface)
          Interface::LeftMenu.ressources
        end
      end

      def proceed
        return false unless BuildLoops.any?
        puts "there is something to build !"

        BuildLoops.all.each do |order|
          Interface::RightMenu.switch_planet(order.planet_coordinates)
          cli_interface_to_nav_link(order.interface)
          Interface::Building.find(order).click
          order.delete
        end
      end
    end
  end
end