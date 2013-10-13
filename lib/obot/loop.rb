class Loop
  def initialize(obot, sleep_time = 60)
    @obot       = obot
    @sleep_time = sleep_time
  end

  def run_default
    attack = false
    until attack
      attack = @obot.watch_for_attack
      sleep @sleep_time
    end
    @obot.default_response_for_attacks

    run_default
  end
end