# Dependencies
require 'yaml'
require 'watir-webdriver'

# Obot files
require_relative 'obot/resources'
require_relative 'obot/strategy_move'

class Obot
  ROOT_PATH = 'http://ogame.fr'

  def initialize(config_file)
    @config  = YAML.load_file(config_file)
    @browser = Watir::Browser.new :firefox, profile: @config['firefox_profile']

    login
  end

  def default_response_for_attacks
    attacked_coordinates = get_attack_coordinates
    puts attacked_coordinates

    switch_planet(attacked_coordinates)
    StrategyMove.proceed(@browser, first_unatacked_planet(attacked_coordinates))
  end

  # What happen if we have more than one td ?
  # Must turn this to always return an array
  # Return format : [x:x:x]
  def get_attack_coordinates
    div_attack_alert.click
    @browser
      .table(id: 'eventContent')
        .tr(class: 'eventFleet', data_mission_type: '1')
          .td(class: 'destCoords').text
  end

  def first_unatacked_planet(attacked_coordinates)
    planets = @config['planets']
    planets.delete_if { |planet| "[#{planet}]" == attacked_coordinates }
    planets.first
  end

  def login
    @browser.goto ROOT_PATH
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

  def div_attack_alert
    @browser.div(id: 'attack_alert')
  end

  def coordinates_to_regex(coordinates)
    Regexp.new(Regexp.quote("#{coordinates}"))
  end
end