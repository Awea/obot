# Dependencies
require 'sequel'
require 'watir-webdriver'
require 'yaml'
require 'active_support/concern'

# Obot files
require_relative 'obot/loop'
require_relative 'obot/strategies/move'
require_relative 'obot/interface/start'
require_relative 'obot/interface/menu'
require_relative 'obot/models/planets'
require_relative 'obot/models/spaceships'
require_relative 'obot/sensors/attack'

DB  = Sequel.sqlite 
NAV = Watir::Browser.new :firefox, profile: 'ogame'

NAV.add_checker do |page|
  page.alert.close if page.alert.exists?
end

class Obot
  def initialize(config_file, env)
    @config  = YAML.load_file(config_file)[env]

    Interface::Start.login(@config['auth'])
    Strategies::Move.ready_to_proceed
  end

  def default_response_for_attacks
    Sensors::Attack.get_coordinates.each do |attacked_planet|    
      puts "attacked on #{attacked_planet}"
      Interface::Menu.switch_planet(attacked_planet)
      Strategies::Move.proceed(attacked_planet)

      sleep rand(1..10)
    end
  end
end