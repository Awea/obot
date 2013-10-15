# Dependencies
require 'yaml'
require 'watir-webdriver'

# Obot files
require_relative 'obot/resources'
require_relative 'obot/strategy_move'
require_relative 'obot/models/planets'
require_relative 'obot/models/spaceships'

class Obot
  def initialize(config_file, browser = true)
    @config  = YAML.load_file(config_file)
    Planets.create_table
    Spaceships.create_table
    @browser = new_browser if browser
    @planets = Planets.store_planets(@config['planets']) 

    @browser.add_checker do |page|
      page.alert.close if page.alert.exists?
    end

    login
    get_data_strategy
  end

  # Need to move this somewhere else, it's a procedure
  def default_response_for_attacks
    get_attacks_coordinates.each do |attacked_planet|    
      switch_planet(attacked_planet)
      StrategyMove.proceed(@browser, attacked_planet, first_unatacked_planet(attacked_planet)) if StrategyMove.ready?(attacked_planet)

      sleep rand(1..10)
    end
  end

  def get_data_strategy
    @planets.all.each do |planet|
      switch_planet(planet[:coordinates])
      StrategyMove.get_data(@browser, planet)
    end
  end

  def get_attacks_coordinates
    open_div_attack_alert
    @browser
      .table(id: 'eventContent').when_present
        .tr(class: 'eventFleet', data_mission_type: '1')
          .tds(class: 'destCoords').map{ |attack|
            attack.when_present.text
          }
  end

  def first_unatacked_planet(attacked_coordinates)
    @planets.where("coordinates != '#{attacked_coordinates}'").first
  end

  # untested for the moment
  def login
    @browser.goto 'http://ogame.fr'
    @browser.element(id: 'loginBtn').click
    @browser.select(id: 'serverLogin').select(@config['auth']['server'])
    @browser.text_field(id: 'usernameLogin').set(@config['auth']['login'])
    @browser.text_field(id: 'passwordLogin').set(@config['auth']['passwd'])
    @browser.element(id: 'loginSubmit').click
  end

  def watch_for_attack
    @browser.refresh
    attack = div_attack_alert.attribute_value('class') =~ / (soon|today)/
    !attack.nil?
  end

  def switch_planet(planet_coordinates)
    @browser.span(
      class: 'planet-koords', 
      text: coordinates_to_regex(planet_coordinates)
    ).click
  end

  def stop
    @browser.close
  end

private
  def new_browser
    Watir::Browser.new :firefox, profile: @config['firefox_profile']
  end

  def open_div_attack_alert
    div_attack_alert.click
  end

  def div_attack_alert
    @browser.div(id: 'attack_alert')
  end

  def coordinates_to_regex(coordinates)
    Regexp.new(Regexp.quote("#{coordinates}"))
  end
end