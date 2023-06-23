require 'state_manager'

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
    # NOTE: Would it be better to use a State instead?
    @substate = :playing
  end

  def update(dt)
    case @substate
    when :playing
      playing_update(dt)
    when :pause
      pause_update
    when :gameover
      gameover_update
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

  def pause_update
    return nil unless key_pressed?(KEY_ENTER)

    @substate = :playing
  end

  def gameover_update
    return nil unless key_pressed?(KEY_R)

    @player.reset
    @rival.reset
    @ball.reset

    @substate = :playing
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
    # Transparent rectangle covering the game window to darken
    # the screen a little
    Rectangle.new(0, 0, Game::WINDOW_WIDTH, Game::WINDOW_HEIGHT)
             .draw(colour: Colour.new(0, 0, 0, 100))

    draw_text('-- PAUSE --', 255, 150, 48, WHITE)
  end

  def gameover_draw
    outcome = @player.score == 10 ? 'You win!' : 'You lose!'

    # Top text
    draw_text('The game has ended!', 200, 200, 38, WHITE)

    # Medium text
    draw_text(outcome, 310, 250, 38, WHITE)

    # Bottom text
    draw_text('Press R to restart the game', 130, 550, 38, WHITE)
  end
end
