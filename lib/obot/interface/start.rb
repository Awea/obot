module Interface
  module Start
    def login(config_auth)
      NAV.goto 'http://ogame.fr'
      #NAV.element(id: 'loginBtn').click add a condition here if element visible ?
      NAV.select(id: 'serverLogin').select(config_auth['server'])
      NAV.text_field(id: 'usernameLogin').set(config_auth['login'])
      NAV.text_field(id: 'passwordLogin').set(config_auth['passwd'])
      NAV.element(id: 'loginSubmit').click
    end
    module_function :login
  end
end