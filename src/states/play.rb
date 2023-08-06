require 'state_manager'

require 'ball'
require 'ai'
require 'paddle'
require 'court'

require 'states/pause.rb'
require 'states/gameover.rb'

# Main play state
# Superstate of Pause and Gameover
class Play < StateManager::State
  attr_reader :player, :rival, :ball
  attr_writer :substate

  def on_enter
    @player.reset
    @rival.reset
    @ball.reset
  end

  def initialize
    @player = Paddle.new
    @rival = AI.new

    @ball = Ball.new
    @ball.set_sides(@player, @rival)

    @court = Court.new

    @substates = {pause: Pause.new(self),
                  gameover: GameOver.new(self)}
    # Determines current game flow of action
    # one of :playing,:gameover or :pause
    @substate = :playing
  end

  def update(dt)
    handle_substates(dt)
  end

  def handle_substates(dt)
    case @substate
    when :playing
      playing_update(dt)
    when :pause
      @substates[:pause].update(dt)
    when :gameover
      @substates[:gameover].update(dt)
    end
  end

  def playing_update(dt)
    @player.update(dt)
    @rival.update(dt)
    @rival.track_ball(@ball)
    @ball.update(dt)

    @substate = :pause if key_pressed?(KEY_ENTER)
    @substate = :gameover if @player.score == 10 || @rival.score == 10
  end

  def draw
    @court.draw
    @player.draw
    @rival.draw
    @ball.draw

    # Since we don't wanna stop drawing the play state when drawing the other
    # states, we can just do the case here
    case @substate
    when :pause
      @substates[:pause].draw
    when :gameover
      @substates[:gameover].draw
    end
  end
end
