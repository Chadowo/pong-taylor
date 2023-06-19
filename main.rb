# Add the path ./vendor so we can easily require third party libraries.

$: << './vendor'
$: << './src'

require 'src/paddle'
require 'src/ai'
require 'src/ball'
require 'src/court'

module Game
  attr_reader :player, :rival, :ball

  extend self
  
  include Collision

  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600

  @@state = :play

  # Helper method for setting up everything
  def init_game_objects
    @player = Paddle.new
    @rival = AI.new
    @ball = Ball.new
    @court = Court.new
  end

  def initialize
    # Start our window
    init_window(WINDOW_WIDTH, WINDOW_HEIGHT, 'Pong')
    set_window_icon(load_image('assets/icon.png'))

    # Setup audio so we can play sounds
    init_audio_device

    # Get the current monitor frame rate and set our target framerate to match.
    set_target_fps(get_monitor_refresh_rate(get_current_monitor))

    init_game_objects
  end

  def update(dt)
    # Game logic here
    case @@state
    when :play
      @player.update(dt)
      @rival.update(dt)
      @ball.update(dt)

      if @player.score == 10 || @rival.score == 10
        @@state = :gameover
      end
    when :gameover
      if key_down?(KEY_R)
        @player.reset
        @rival.reset
        @ball.reset
        @@state = :play
      end
    end

    drawing do
      clear
      draw
    end
  end

  def draw
    @court.draw
    @player.draw
    @rival.draw
    @ball.draw

    if @@state == :gameover
      draw_text("The game has ended!", 200, 200, 39, WHITE)

      outcome = @player.score == 10 ? 'You win!' : 'You lose!'
      draw_text(outcome, 300, 250, 39, WHITE)
      draw_text('Press R to restart the game', 150, 400, 39, WHITE)
    end
  end

  def loop
    update(get_frame_time) until window_should_close?
  end

  def finalize
    close_audio_device
    close_window
  end
end

Game.initialize
Game.loop
Game.finalize
