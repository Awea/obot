require 'yaml'
require 'active_support/concern'

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
    get_planets
  end

  def build_something?
    if BuildLoops.any?
      Behaviours::Build.proceed 
      puts "there is something to build !"
    end
  end

  def default_response_for_attacks 
    Sensors::Attack.get_coordinates.each do |attacked_planet|    
      puts "attacked on #{attacked_planet}"
      Behaviours::MoveMinerals.proceed(attacked_planet)

      sleep rand(1..10)
    end
  end

  def get_planets
    # Grab all planets coordinates and store them
    planets = NAV.spans(class: 'planet-koords').map{ |coordinates|
                  coordinates.when_present.text
                }
    puts planets.inspect
    Planets.store_scraped_planets(planets) 
  end

  def login
    Interface::Start.login(@config['auth'])
  end

  def need_to_login_again?
    Interface::Start.logged_in?
  end
end