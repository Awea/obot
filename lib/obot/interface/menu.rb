module Interface
  class LeftMenu
    class << self
      %w{Installations Ressources}.each do |text_link|
        define_method(text_link.downcase) { click_element(text_link) }
      end

      private

      def click_element(text_link)
        NAV.ul(id: 'menuTable').element(class: 'menubutton', text: text_link).when_present.click
      end
    end
  end

  class RightMenu
    class << self
      def switch_planet(coordinates)
        NAV.span(
          class: 'planet-koords', 
          text: Regexp.new(Regexp.quote("#{coordinates}"))
        ).click
      end
    end
  end
end