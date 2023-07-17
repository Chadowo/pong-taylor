require 'state_manager'

class GameOver < StateManager::State
  def initialize(superstate)
    @superstate = superstate
  end

  def update(_dt)
    return nil unless key_pressed?(KEY_R)

    @superstate.on_enter

    @superstate.substate = :playing
  end

  def draw
    outcome = @superstate.player.score == 10 ? 'You win!' : 'You lose!'

    # Top text
    draw_text('The game has ended!', 200, 200, 38, WHITE)

    # Medium text
    draw_text(outcome, 310, 250, 38, WHITE)

    # Bottom text
    draw_text('Press R to restart the game', 130, 550, 38, WHITE)
  end
end
