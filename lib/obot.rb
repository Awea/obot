# Dependencies
require 'yaml'
#require 'watir-webdriver'

# Obot files
require_relative 'obot/strategies/move'
require_relative 'obot/interface/start'
require_relative 'obot/interface/menu'
require_relative 'obot/models/planets'
require_relative 'obot/models/spaceships'
require_relative 'obot/sensors/attack'

class Obot
  attr_reader :config

  def initialize(config_file)
    @config  = YAML.load_file(config_file)
  end

  def default_response_for_attacks
    Sensors::Attack.get_coordinates.each do |attacked_planet|    
      puts "attacked on #{attacked_planet}"
      Interface::Menu.switch_planet(attacked_planet)
      StrategyMove.proceed(attacked_planet)

      sleep rand(1..10)
    end
  end
end