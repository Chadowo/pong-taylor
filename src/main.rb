$: << 'src'

require 'state_manager'
require 'states/play'
require 'states/menu'

require 'version'

# Core game module, everything happens here
module Game
  attr_accessor :running

  extend self

  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600

  @running = true

  def init
    Window.open(width: WINDOW_WIDTH, height: WINDOW_HEIGHT, title: 'Pong')
    Window.icon = Image.new('assets/icon.png')

    Audio.open

    # Get the current monitor frame rate and set our target framerate to match
    Window.target_frame_rate = Monitor.current.refresh_rate

    StateManager.set_state(Menu.new)
  end

  def update(dt)
    # Handle game logic based on current state
    StateManager.update(dt)

    # Rendering logic
    Window.draw do
      Window.clear
      StateManager.draw
    end
  end

  # Loop our game until it ends
  def loop
    # Ends the game if running is false or if the window
    # should close (user presses the X or hits ESC)
    update(Window.frame_time) while @running && !Window.close?
  end

  # Needed for closing resources used in taylor
  # NOTE: Don't call this to end the game, instead set Game#running to false
  def finalize
    Window.close
    Audio.close
  end
end

Game.init
Game.loop
Game.finalize
