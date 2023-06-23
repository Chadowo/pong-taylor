require 'state_manager'

require 'src/court'
require 'src/states/play'

# Menu state
class Menu < StateManager::State
  # A button has a label and an action, the action
  # being a lambda
  Button = Struct.new(:label, :action)

  def initialize
    super()

    @court = Court.new

    @buttons = [Button.new('Play', -> { StateManager.set_state(Play.new) }),
                Button.new('Exit', -> { Game.running = false })]
    @current_option = 0

    # The y of the pointer that show the user their choice.
    # TODO: I reckon there should be a better way than hard-coding the coord
    @pointer_y = 300
  end

  def update(dt)
    # This handles our game's menu control, since our buttons are drawed
    # from top to bottom the 0 index is the topmost button
    if key_pressed?(KEY_UP) && @current_option > 0
      @current_option -= 1
      @pointer_y -= 58
    elsif key_pressed?(KEY_DOWN) && @current_option < (@buttons.length - 1)
      @current_option += 1
      @pointer_y += 58
    end

    return nil unless key_pressed?(KEY_ENTER)

    @buttons[@current_option].action.call
  end

  def draw
    # BG
    @court.draw

    # Title
    draw_text('Pong', 30, 150, 64, WHITE)

    draw_buttons

    Rectangle.new(5, @pointer_y, 10, 30).draw(colour: WHITE)

    # Version number
    draw_text("V#{Game::VERSION}", 750, 580, 20, WHITE)
  end

  def draw_buttons
    offset_y = 0

    @buttons.each do |btn|
      margin = 20
      font_height = 38

      draw_text(btn.label, 30, (300 + offset_y), font_height, WHITE)

      offset_y += (font_height + margin)
    end
  end
end
