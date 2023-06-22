# Add the path ./vendor so we can easily require third party libraries.
$: << './vendor'
$: << './src'

require 'state_manager'

require 'src/states/play'
require 'src/states/menu'

# Core game module, everything happens here
module Game
  extend self

  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600
  VERSION = '1.1.0'.freeze

  def initialize
    init_window(WINDOW_WIDTH, WINDOW_HEIGHT, 'Pong')
    set_window_icon(load_image('assets/icon.png'))

    init_audio_device

    # Get the current monitor frame rate and set our target framerate to match
    set_target_fps(get_monitor_refresh_rate(get_current_monitor))

    StateManager.set_state(Menu.new)
  end

  def update(dt)
    # Handle game logic based on current state
    StateManager.update(dt)

    # Rendering logic
    drawing do
      clear
      StateManager.draw
    end
  end

  # Loop our game until we should close the window
  def loop
    update(get_frame_time) until window_should_close?
  end

  # Needed for closing resources used in taylor
  def finalize
    close_window
    close_audio_device
  end
end

Game.initialize
Game.loop
Game.finalize
