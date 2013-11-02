module Behaviours
  module Build
    def build_something(build_type)
      case build_type
      when 'metal'   then build_metal
      when 'crystal' then build_crystal
      when 'deut'    then build_deut
      when 'solar'   then build_solar
      end
    end
    module_function :build_something

    def move_to_origin
      NAV.ul(id: 'menuTable').element(class: 'menubutton', text: 'Ressources').click
    end
    module_function :move_to_origin

    def proceed
      orders = BuildLoops.all # Get all build to do

      orders.each do |order|
        Interface::Menu.switch_planet(order[:coordinates])
        move_to_origin
        build_something(order[:type])
      end
    end
    module_function :proceed

    def build_metal
      build_element_click('button1') #if build_element_exist?('button1')
    end
    module_function :build_metal

    def build_crystal
      build_element_click('button2') if build_element_exist?('button2')
    end
    module_function :build_crystal 

    def build_deut
      build_element_click('button3') if build_element_exist?('button3')
    end
    module_function :build_deut

    def build_solar
      build_element_click('button4') if build_element_exist?('button4')
    end
    module_function :build_solar

    def build_element(class_li)
      NAV.ul(id: 'building').li(id: class_li).link(class: 'fastBuild')
    end
    module_function :build_element

    def build_element_click(class_li)
      build_element(class_li).click
    end
    module_function :build_element_click

    def build_element_exist?(class_li)
      build_element(class_li).exist?
    end
    module_function :build_element_exist?
  end
end