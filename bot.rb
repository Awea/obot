require_relative 'lib/obot'

obot = Obot.new('config.yml')
attack = false
loop_time = 30

#until attack
#  attack = obot.watch_for_attack
#  sleep loop_time
#end

obot.default_response_for_attacks

#attacked_coordinates  = obot.get_attack_coordinates
#unatacked_coordinates = obot.first_unatacked_planet
#
## Go to the planet
#obot.switch_planet(attacked_coordinates)

sleep 4
obot.stop