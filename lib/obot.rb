# Dependencies
require 'yaml'
require 'watir-webdriver'

# Obot files
require_relative 'obot/resources'

class Obot
  ROOT_PATH = 'http://ogame.fr'

  def initialize(config_file)
    @config  = YAML.load_file(config_file)
    @browser = Watir::Browser.new :firefox, profile: @config['firefox_profile']

    login
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
    attack = @browser.element(id: 'attack_alert').attribute_value('class') =~ /( soon)/
    !attack.nil?
  end

  def switch_planet(planet_number)
    @browser.span(
      class: 'planet-koords', 
      text: coordinates_to_regex(@config['planets'][planet_number])
    ).click
  end

  def stop
    @browser.close
  end

private

  def coordinates_to_regex(coordinates)
    Regexp.new(Regexp.quote("[#{coordinates}]"))
  end
end