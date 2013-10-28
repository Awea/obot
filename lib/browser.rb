require 'watir-webdriver'

client         = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 120
NAV            = Watir::Browser.new :firefox, profile: 'ogame', http_client: client

NAV.add_checker do |page|
  page.alert.close if page.alert.exists?
end