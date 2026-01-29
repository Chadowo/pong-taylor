require 'entities/court'

require 'state_manager'
require 'states/play'

puts 'test'

# Menu state
class Menu < StateManager::State
  # A button has a label and an action, the action
  # being a lambda/proc
  Button = Struct.new(:label, :action)

  def initialize
    super()

    @court = Court.new

    @buttons = [Button.new('Play', -> { StateManager.set_state(Play.new) }),
                Button.new('Exit', -> { Game.running = false })]
    @current_option = 0

    # The y of the cube that shows the player's choice
    # TODO: Harcoded coord
    @arrow_y = 300
  end

  def update(dt)
    # This handles our game's menu control, since our buttons are drawed
    # from top to bottom the 0 index is the topmost button
    if Key.pressed?(Key::UP) && @current_option.positive?
      @current_option -= 1
      @arrow_y -= 58
    elsif Key.pressed?(Key::DOWN) && @current_option < (@buttons.length - 1)
      @current_option += 1
      @arrow_y += 58
    end

    return nil unless Key.pressed?(Key::ENTER)

    @buttons[@current_option].action.call
  end

  def draw
    # Bg
    @court.draw
    Rectangle.new(x: 0, y: 0, width: Game::WINDOW_WIDTH, height: Game::WINDOW_HEIGHT,
                  colour: Colour.new(red: 0, green: 0, blue: 0, alpha: 70))
             .draw

    # Title
    Font.default.draw('Pong', size: 64, position: Vector2[30, 150], colour: Colour::WHITE)

    draw_buttons

    Rectangle.new(x: 5, y: @arrow_y, width: 10, height: 30, colour: Colour::WHITE).draw

    # Version number
    Font.default.draw("V#{Game::VERSION}", size: 20, position: Vector2[750, 580], colour: Colour::WHITE)
  end

  def draw_buttons
    offset_y = 0

    @buttons.each do |btn|
      margin = 20
      font_height = 38

      Font.default.draw(btn.label, size: font_height, position: Vector2[30, (300 +  offset_y)], colour: Colour::WHITE)

      offset_y += (font_height + margin)
    end
  end
end
