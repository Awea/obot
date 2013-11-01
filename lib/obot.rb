require 'yaml'
require 'active_support/concern'

require_relative 'obot/strategies/move'
require_relative 'obot/interface/start'
require_relative 'obot/interface/menu'
require_relative 'obot/sensors/attack'

class Obot
  def initialize(config_file, env)
    @config  = YAML.load_file(config_file)[env]

    login
    
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

  def login
    Interface::Start.login(@config['auth'])
  end

  def need_to_login_again?
    Interface::Start.logged_in?
  end
end