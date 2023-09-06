require 'state_manager'

class Pause < StateManager::State
  def initialize(superstate)
    @superstate = superstate

    @current_option = 0

    @arrow_y = 250
  end

  def update(_dt)
    if key_pressed?(KEY_UP) && @current_option > 0
      @current_option -= 1
      @arrow_y = 250
    elsif key_pressed?(KEY_DOWN) && @current_option < (1)
      @current_option += 1
      @arrow_y = 300
    end

    return nil unless key_pressed?(KEY_ENTER)

    if @current_option.zero?
      @superstate.substate = :playing
    else
      StateManager.set_state(Menu.new)
    end
  end

  def draw
    # Transparent rectangle covering the game window to darken
    # the screen a little
    Rectangle.new(0, 0, Game::WINDOW_WIDTH, Game::WINDOW_HEIGHT)
             .draw(colour: Colour.new(0, 0, 0, 100))

    draw_text('-- PAUSE --', 255, 150, 48, WHITE)
    Rectangle.new(295, @arrow_y, 10, 30).draw(colour: WHITE)

    draw_buttons
  end

  def draw_buttons
    draw_text('Resume', 320, 250, 38, WHITE)
    draw_text('Menu', 320, 300, 38, WHITE)
  end
end
