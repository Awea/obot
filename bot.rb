require_relative 'lib/obot'

obot = Obot.new('config.yml')
attack = false
loop_time = 30

until attack
  attack = obot.watch_for_attack
  puts attack.to_s
  puts attack ? "Pas tranquille" : "Tranquille"
  sleep loop_time
end