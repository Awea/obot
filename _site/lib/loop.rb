class Loop
  def initialize(obot, sleep_time = 900)
    @obot                  = obot
    @sleep_time            = sleep_time
    @time_since_last_watch = 0
  end

  def run_default
    attack       = false

    until attack
      @obot.login if @obot.need_to_login_again?
      @obot.build_something?
      attack = Sensors::Attack.watch_for_attack if time_to_watch?
      puts "You are under attack !" if attack
      sleep 1

      if watching_period?
        @time_since_last_watch += 1     
      else
        @time_since_last_watch = 0
      end
    end
    @obot.default_response_for_attacks

    run_default
  end

  private

  def time_to_watch?
    @sleep_time == @time_since_last_watch
  end

  def watching_period?
    !Time.now.hour.between?(2,6) && @time_since_last_watch < @sleep_time
  end
end