module Sensors
  module Attack
    def div_attack_alert
      NAV.div(id: 'attack_alert')
    end
    module_function :div_attack_alert

    def get_coordinates
      open_div_attack_alert
      NAV.table(id: 'eventContent').when_present
        .tr(class: 'eventFleet', data_mission_type: '1')
        .tds(class: 'destCoords').map{ |attack|
          attack.when_present.text
        }
    end
    module_function :get_coordinates

    def open_div_attack_alert
      div_attack_alert.click
    end
    module_function :open_div_attack_alert

    def watch_for_attack
      NAV.refresh
      attack = div_attack_alert.attribute_value('class') =~ / (soon|today)/
      !attack.nil?
    end
    module_function :watch_for_attack
  end
end