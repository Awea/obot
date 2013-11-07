require 'watir-webdriver'

client         = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 120
# I will use phantomjs for production
NAV            = Watir::Browser.new :firefox, profile: 'ogame', http_client: client 

# This will not work with phantomjs
# Is it necessary ?
NAV.add_checker do |page|
  page.alert.close if page.alert.exists? 
end