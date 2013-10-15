class StrategyMove
  class << self
    def move_to_origin(browser)
      browser.ul(id: 'menuTable').element(class: 'menubutton', text: 'Flotte').click
    end

    def get_data(browser, planet)
      move_to_origin(browser)
      Spaceships.add_transports_to_planet(count_big_transports(browser), planet[:id]) if browser_big_transports?(browser)
    end

    def ready?(origin)
      persisted_big_transports?(origin)
    end

    # origin is a [c:o:d]
    # destination is an array from Planets class :s
    def proceed(browser, origin, destination)
      # Go in fleet
      move_to_origin(browser)
      # Select all big transport
      big_transports_container(browser).link(class: 'tooltip').click
      # Next fleet page
      browser.link(id: 'continue').click
      sleep(2)
      # Fill destination form
      splitted_destination = destination[:coordinates].split(':')
      browser.text_field(id: 'galaxy').set(splitted_destination[0])
      browser.text_field(id: 'system').set(splitted_destination[1])
      browser.text_field(id: 'position').set(splitted_destination[2])
      # Next fleet page
      browser.link(id: 'continue').click
      sleep(2)
      # Select park order
      puts browser.link(id: 'missionButton4').click
      # Take all resources
      browser.link(id: 'allresources').click
      # Launch fleet
      browser.link(id: 'start').click
    
      Spaceships.transfert_transports(origin, destination[:id])
    end

    def browser_big_transports?(browser)
       big_transports_container(browser).exist?
    end

    def persisted_big_transports?(coordinates)
      planet = Planets.find_by_coordinates(coordinates)
      Spaceships.transports_available_by_planet(planet[:id]) > 0
    end

    def count_big_transports(browser)
      sleep(2)
      big_transports_container(browser).when_present.link.text
    end

    def big_transports_container(browser)
      browser.li(id: 'button203').div(class: 'buildingimg')
    end
  end
end