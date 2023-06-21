# Add the path ./vendor so we can easily require third party libraries.
$: << './vendor'
$: << './src'

require 'src/paddle'
require 'src/ai'
require 'src/ball'
require 'src/court'

# Core game module, everything happens here
module Game
  attr_reader :player, :rival, :ball

  extend self

  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600

  # Game state, two values are possible;
  # :play or :gameover
  @state = :play

  def initialize
    init_window(WINDOW_WIDTH, WINDOW_HEIGHT, 'Pong')
    set_window_icon(load_image('assets/icon.png'))

    init_audio_device

    # Get the current monitor frame rate and set our target framerate to match
    set_target_fps(get_monitor_refresh_rate(get_current_monitor))

    # Setup our game objects
    @player = Paddle.new
    @rival = AI.new
    @ball = Ball.new
    @court = Court.new
  end

  def update(dt)
    # Handle game logic based on current state
    case @state
    when :play
      play(dt)
    when :gameover
      gameover
    end

    # Rendering logic
    drawing do
      clear
      draw
    end
  end

  def play(dt)
    @player.update(dt)
    @rival.update(dt)
    @ball.update(dt)

    @state = :gameover if @player.score == 10 || @rival.score == 10
  end

  def gameover
    return nil unless key_down?(KEY_R)

    @player.reset
    @rival.reset
    @ball.reset

    @state = :play
  end

  def draw
    @court.draw
    @player.draw
    @rival.draw
    @ball.draw

    return nil unless @state == :gameover

    outcome = @player.score == 10 ? 'You win!' : 'You lose!'

    draw_text('The game has ended!', 200, 200, 38, WHITE)
    draw_text(outcome, 310, 250, 39, WHITE)
    draw_text('Press R to restart the game', 130, 550, 38, WHITE)
  end

  # Loop our game until we should close the window
  def loop
    update(get_frame_time) until window_should_close?
  end

  # Needed for closing resources used in taylor
  def finalize
    close_audio_device
    close_window
  end
end

Game.initialize
Game.loop
Game.finalize
