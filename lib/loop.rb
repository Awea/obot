class Loop
  def initialize(obot, sleep_time = 60)
    @obot       = obot
    @sleep_time = sleep_time
    @first_run  = true
  end

  def run_default
    attack = false
    until attack
      puts "intoooo the looop"
      @obot.login if @obot.need_to_login_again?
      @obot.build_something?
      attack = Sensors::Attack.watch_for_attack
      puts "You are under attack !" if attack
      sleep @sleep_time * rand(1..30) unless @first_run
      @first_run = false if @first_run
    end
    @obot.default_response_for_attacks

    run_default
  end
end