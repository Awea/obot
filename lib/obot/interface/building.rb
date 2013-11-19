module Interface
  class Building
    def initialize(build_loop)
      @ul = uls[build_loop.interface.to_sym] 
      @li_class = @ul[:li_classes][build_loop.building.to_sym]
    end

    def uls
      {
        re: {
          ul_id: 'building',
          li_classes: {
            metal:   'button1',
            crystal: 'button2',
            deut:    'button3',
            solar:   'button4'
          } 
        },
        su: {
          ul_id: 'storage',
          li_classes: {
            metal:   'button7',
            crystal: 'button8',
            deut:    'button9'
          } 
        },
        in: {
          ul_id: 'stationbuilding',
          li_classes: {
            robot:   'button0',
            nanite:  'button5'
          } 
        }
      }
    end

    def ul_id
      @ul[:ul_id]
    end 

    def element
      NAV.ul(id: ul_id).li(id: @li_class).link(class: 'fastBuild')
    end

    def click
      element.click if element_exist?
    end

    def element_exist?
      element.exist?
    end
  end
end