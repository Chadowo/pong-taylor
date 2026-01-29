$: << 'src'

require 'state_manager'
require 'states/play'
require 'states/menu'

require 'version'

# Core game class, everything happens here
# NOTE: singleton
class GamePong
  attr_accessor :close

  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600

  # TODO: Ugly hack to keep track of the created instance of GamePong, used
  #       by the menu when setting @close for quitting the game.
  class << self; attr_accessor :instance; end

  def initialize
    Window.open(width: WINDOW_WIDTH, height: WINDOW_HEIGHT, title: 'Pong')
    Window.icon = Image.new('assets/icon.png')

    Audio.open

    @close = false

    self.class.instance = self

    # Get the current monitor frame rate and set our target framerate to match
    Window.target_frame_rate = Monitor.current.refresh_rate

    StateManager.set_state(Menu.new)
  end

  def tick(dt)
    # Handle game logic based on current state
    StateManager.update(dt)

    # Rendering logic
    Window.draw do
      Window.clear
      StateManager.draw
    end
  end

  def start
    tick(Window.frame_time) until Window.close? || @close

    finalize
  end

  # Needed for closing resources used in taylor
  def finalize
    Window.close
    Audio.close
  end
end

GamePong.new.start
