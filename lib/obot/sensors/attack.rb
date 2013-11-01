module Sensors
  module Attack
    def div_attack_alert
      NAV.div(id: 'attack_alert')
    end
    module_function :div_attack_alert

    def tr_attack
      NAV.table(id: 'eventContent').tr(class: 'eventFleet', data_mission_type: '1')
    end
    module_function :tr_attack

    def div_attack_alert?
      div_attack_alert.exist?
    end
    module_function :div_attack_alert?

    def tr_attack?
      tr_attack.exist?
    end
    module_function :tr_attack?

    def get_coordinates
      open_div_attack_alert
      tr_attack.tds(class: 'destCoords').map{ |attack|
        attack.when_present.text.gsub(/\[|\]/, '')
      } if tr_attack?
    end
    module_function :get_coordinates

    def open_div_attack_alert
      div_attack_alert.click
    end
    module_function :open_div_attack_alert

    def watch_for_attack
      NAV.refresh
      attack = div_attack_alert? ? div_attack_alert.attribute_value('class') =~ / (soon|today)/ : nil
      !attack.nil?
    end
    module_function :watch_for_attack
  end
end