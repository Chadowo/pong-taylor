require 'state_manager'

require 'src/court'
require 'src/states/play'

# Menu state
class Menu < StateManager::State
  # A button has a label and an action, the action
  # being an lambda
  Button = Struct.new(:label, :action)

  def initialize
    super()
    @court = Court.new
    @current_option = 0
    @buttons = [Button.new('Play', -> { StateManager.set_state(Play.new) }),
                Button.new('Exit', -> { Game.finalize })]
  end

  def update(dt)
    if key_pressed?(KEY_DOWN)
      @current_option += 1 unless @current_option >= @buttons.length - 1
    elsif key_pressed?(KEY_UP)
      @current_option -= 1 unless @current_option <= 0
    end

    return nil unless key_pressed?(KEY_ENTER)

    @buttons[@current_option].action.call
  end

  # TODO: Draw a marker indicating the player's choice
  def draw
    @court.draw
    draw_text('Pong', 50, 150, 64, WHITE)
    draw_text("Your option: #{@buttons[@current_option].label}",
              10, 580, 16, WHITE)

    @buttons.each_with_index do |opt, idx|
      offset_y = (idx + 1) * 60
      draw_text(opt.label, 50, (200 + offset_y), 48, WHITE)
    end
  end
end
