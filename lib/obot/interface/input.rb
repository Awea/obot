module Interface
  class InputFleetDestination
    class << self
      def set(coordinates)
        splitted_destination = coordinates.split(':')
        NAV.text_field(id: 'galaxy').set(splitted_destination[0])
        NAV.text_field(id: 'system').set(splitted_destination[1])
        NAV.text_field(id: 'position').set(splitted_destination[2])
      end
    end
  end
end