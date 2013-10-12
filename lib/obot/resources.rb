class Resources
  class << self
    def create(browser)
      browser.ul(id: 'menuTable').element(text: 'Ressources').click
      browser.div(class: resource_div_id).element(class: 'fastBuild').click
    end

    def resource_div_id
      raise NotImplementedError
    end
  end
end

require_relative 'resources/metal'
require_relative 'resources/cristal'
require_relative 'resources/deut'