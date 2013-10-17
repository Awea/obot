class Loop
  def initialize(obot, sleep_time = 60)
    @obot       = obot
    @sleep_time = sleep_time
    @first_run  = true

    Interface::Start.login(@obot.config['auth'])
    Strategy::Move.ready_to_proceed
  end

  def run_default
    attack = false
    until attack
      attack = Sensors::Attack.watch_for_attack
      sleep @sleep_time * rand(1..30) unless @first_run
    end
    @obot.default_response_for_attacks

    run_default
  end
end