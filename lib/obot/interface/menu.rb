module Interface
  module Menu
    def switch_planet(planet_coordinates)
      NAV.span(
        class: 'planet-koords', 
        text: coordinates_to_regex(planet_coordinates)
      ).click
    end
    module_function :switch_planet

    def coordinates_to_regex(coordinates)
      Regexp.new(Regexp.quote("#{coordinates}"))
    end
    module_function :coordinates_to_regex
  end
end