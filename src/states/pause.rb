require 'state_manager'

class Pause < StateManager::State
  def initialize(superstate)
    @superstate = superstate
  end

  def update(_dt)
    return nil unless key_pressed?(KEY_ENTER)

    @superstate.substate = :playing
  end

  def draw
    # Transparent rectangle covering the game window to darken
    # the screen a little
    Rectangle.new(0, 0, Game::WINDOW_WIDTH, Game::WINDOW_HEIGHT)
             .draw(colour: Colour.new(0, 0, 0, 100))

    draw_text('-- PAUSE --', 255, 150, 48, WHITE)
  end
end
