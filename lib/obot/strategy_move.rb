class StrategyMove
  def self.proceed(browser, destination)
    # Go in fleet
    browser.ul(id: 'menuTable').element(class: 'menubutton', text: 'Flotte').click
    # Select all big transport
    browser.li(id: 'button203').div(class: 'buildingimg').link(class: 'tooltip').click
    # Next fleet page
    browser.link(id: 'continue').click
    sleep(2)
    # Fill destination form
    splitted_destination = destination.split(':')
    browser.text_field(id: 'galaxy').set(splitted_destination[0])
    browser.text_field(id: 'system').set(splitted_destination[1])
    browser.text_field(id: 'position').set(splitted_destination[2])
    # Next fleet page
    browser.link(id: 'continue').click
    sleep(2)
    # Select park order
    puts browser.link(id: 'missionButton4').click
    # Take all resources
    browser.link(id: 'allresources').click
    # Launch fleet
    browser.link(id: 'start').click
  end
end