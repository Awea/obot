module Sensors
  class Attack
    class << self
      def div_attack_alert
        NAV.div(id: 'attack_alert')
      end

      def tr_attack
        NAV.table(id: 'eventContent').tr(class: 'eventFleet', data_mission_type: '1')
      end

      def div_attack_alert?
        div_attack_alert.exist?
      end

      def tr_attack?
        tr_attack.exist?
      end

      def get_coordinates
        open_div_attack_alert
        tr_attack.tds(class: 'destCoords').map{ |attack|
          attack.when_present.text.gsub(/\[|\]/, '')
        } if tr_attack?
      end

      def open_div_attack_alert
        div_attack_alert.click
      end

      def watch_for_attack
        NAV.refresh
        attack = div_attack_alert? ? div_attack_alert.attribute_value('class') =~ / (soon|today)/ : nil
        !attack.nil?
      end
    end
  end
end