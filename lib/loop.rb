class Loop
  def initialize(obot, sleep_time = 60)
    @obot       = obot
    @sleep_time = sleep_time
    @first_run  = true
  end

  def run_default
    attack       = false
    time_in_loop = 0

    until attack
      puts "intoooo the looop"
      @obot.login if @obot.need_to_login_again?
      @obot.build_something?
      attack = Sensors::Attack.watch_for_attack if time_in_loop == sleep_time
      puts "You are under attack !" if attack
      sleep 1
      time_in_loop += 1
      @first_run    = false if @first_run
    end
    @obot.default_response_for_attacks

    run_default
  end

  private
  
  def sleep_time
    @sleep_time * rand(1..30)
  end
end