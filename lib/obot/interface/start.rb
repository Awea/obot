module Interface
  module Start
    def login(config_auth)
      NAV.goto 'http://ogame.fr'
      NAV.element(id: 'loginBtn').click unless NAV.div(id: 'login').visible?
      NAV.select(id: 'serverLogin').select(config_auth['server'])
      NAV.text_field(id: 'usernameLogin').set(config_auth['login'])
      NAV.text_field(id: 'passwordLogin').set(config_auth['passwd'])
      NAV.element(id: 'loginSubmit').click
    end
    module_function :login

    def logged_in?
      NAV.title == 'Page d`accueil OGame'
    end
    module_function :logged_in?
  end
end