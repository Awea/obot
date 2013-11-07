module Behaviours
  module Build
    def build_something(build_type)
      case build_type
      when 'metal'      then build_metal
      when 'crystal'    then build_crystal
      when 'deut'       then build_deut
      when 'solar'      then build_solar
      when 'su:metal'   then build_su_metal
      when 'su:crystal' then build_su_crystal
      when 'su:deut'    then build_su_deut
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
      build_element_click('building', 'button1') 
    end
    module_function :build_metal

    def build_crystal
      build_element_click('building', 'button2') 
    end
    module_function :build_crystal 

    def build_deut
      build_element_click('building', 'button3') 
    end
    module_function :build_deut

    def build_solar
      build_element_click('building', 'button4') 
    end
    module_function :build_solar

    def build_su_metal
      build_element_click('storage', 'button7') 
    end
    module_function :build_su_metal

    def build_su_crystal
      build_element_click('storage', 'button8') 
    end
    module_function :build_su_crystal

    def build_su_deut
      build_element_click('storage', 'button9') 
    end
    module_function :build_su_deut

    def build_element(id_ul, class_li)
      NAV.ul(id: id_ul).li(id: class_li).link(class: 'fastBuild')
    end
    module_function :build_element

    def build_element_click(id_ul, class_li)
      build_element(id_ul, class_li).click if build_element_exist?(id_ul, class_li)
    end
    module_function :build_element_click

    def build_element_exist?(id_ul, class_li)
      build_element(id_ul, class_li).exist?
    end
    module_function :build_element_exist?
  end
end