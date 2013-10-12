require 'yaml'
require 'watir-webdriver'

config = YAML.load_file('config.yml')

browser = Watir::Browser.new :firefox
browser.goto "http://ogame.fr"

DIV_METAL   = 'supply1'
DIV_CRYSTAL = 'supply2'
DIV_DEUT    = 'supply3'

# Open the Login form
browser.element(id: 'loginBtn').click
browser.select(id: 'serverLogin').select(config['auth']['server'])
browser.text_field(id: 'usernameLogin').set(config['auth']['login'])
browser.text_field(id: 'passwordLogin').set(config['auth']['passwd'])
# Submit Login Form
browser.element(id: 'loginSubmit').click

# Go to Colonie resources view
browser.goto "http://uni123.ogame.fr/game/index.php?page=resources&cp=33637392"
browser.div(class: DIV_METAL).element(class: 'fastBuild').click

# Go to another Colonie resources view
browser.goto "http://uni123.ogame.fr/game/index.php?page=resources&cp=33650615"
browser.div(class: DIV_METAL).element(class: 'fastBuild').click

browser.close