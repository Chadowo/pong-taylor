require 'state_manager'

class Pause < StateManager::State
  def initialize(superstate)
    @superstate = superstate

    @current_option = 0

    @arrow_y = 250
  end

  def update(dt)
    if Key.pressed?(Key::UP) && @current_option.positive?
      @current_option -= 1
      @arrow_y = 250
    elsif Key.pressed?(Key::DOWN) && @current_option < (1)
      @current_option += 1
      @arrow_y = 300
    end

    return nil unless Key.pressed?(Key::ENTER)

    if @current_option.zero?
      @superstate.substate = :playing
    else
      StateManager.set_state(Menu.new)
    end
  end

  def draw
    # Transparent rectangle covering the game window to darken
    # the screen a little
    Rectangle.new(x: 0, y: 0, width: GamePong::WINDOW_WIDTH, height: GamePong::WINDOW_HEIGHT,
                  colour: Colour.new(red: 0, green: 0, blue: 0, alpha: 100))
             .draw

    Font.default.draw('-- PAUSE --', size: 48, position: Vector2[255, 150], colour: Colour::WHITE)
    Rectangle.new(x: 295, y: @arrow_y, width: 10, height: 30, colour: Colour::WHITE).draw

    draw_buttons
  end

  def draw_buttons
    Font.default.draw('Resume', size: 38, position: Vector2[320, 250], colour: Colour::WHITE)
    Font.default.draw('Menu', size: 38, position: Vector2[320, 300], colour: Colour::WHITE)
  end
end
