require 'state'

require 'src/ball'
require 'src/ai'
require 'src/paddle'
require 'src/court'

# Main play state
class Play < StateManager::State
  attr_reader :player, :rival, :ball

  def on_enter
    @player.reset
    @rival.reset
    @ball.reset
  end

  def initialize
    super()

    @player = Paddle.new
    @rival = AI.new

    @ball = Ball.new
    @ball.set_sides(@player, @rival)

    @court = Court.new

    # Determines current game flow of action
    # one of :playing,:gameover or :pause
    @substate = :playing
  end

  def update(dt)
    case @substate
    when :playing
      @player.update(dt)
      @rival.update(dt)
      @rival.track_ball(@ball)
      @ball.update(dt)

      @substate = :gameover if @player.score == 10 || @rival.score == 10
      @substate = :pause if key_pressed?(KEY_ENTER)
    when :pause
      if key_pressed?(KEY_ENTER)
        @substate = :playing
      end
    when :gameover
      if key_pressed?(KEY_R)
        @player.reset
        @rival.reset
        @ball.reset
        @substate = :playing
      end
    end
  end

  def draw
    @court.draw
    @player.draw
    @rival.draw
    @ball.draw


    case @substate
    when :pause
      pause_draw
    when :gameover
      gameover_draw
    end
  end

  def pause_draw
    Rectangle.new(0, 0, Game::WINDOW_WIDTH, Game::WINDOW_HEIGHT)
             .draw(colour: Colour.new(0, 0, 0, 100))
    draw_text('-- PAUSE --', 255, 150, 48, WHITE)
  end

  def gameover_draw
    outcome = @player.score == 10 ? 'You win!' : 'You lose!'

    draw_text('The game has ended!', 200, 200, 38, WHITE)
    draw_text(outcome, 310, 250, 39, WHITE)
    draw_text('Press R to restart the game', 130, 550, 38, WHITE)
  end
end
