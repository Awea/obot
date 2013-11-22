require 'yaml'

require_relative 'obot/behaviours/move_minerals'
require_relative 'obot/behaviours/build'
require_relative 'obot/interface/start'
require_relative 'obot/interface/menu'
require_relative 'obot/interface/building'
require_relative 'obot/sensors/attack'

class Obot
  def initialize(config_file, env)
    @config  = YAML.load_file(config_file)[env]

    login
  end

  def build_something?
    if BuildLoops.any?
      puts "there is something to build !"
      Behaviours::Build.proceed 
    end
  end

  def default_response_for_attacks 
    Sensors::Attack.get_coordinates.each do |attacked_planet|    
      puts "attacked on #{attacked_planet}"
      Behaviours::MoveMinerals.proceed(attacked_planet)

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