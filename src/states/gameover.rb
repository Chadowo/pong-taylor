require 'state_manager'

class GameOver < StateManager::State
  def initialize(superstate)
    @superstate = superstate
  end

  def update(_dt)
    return nil unless Key.pressed?(Key::R)

    @superstate.on_enter

    @superstate.substate = :playing
  end

  def draw
    outcome = @superstate.player.score == 10 ? 'You win!' : 'You lose!'

    # Top text
    Font.default.draw('The game has ended!', size: 38, position: Vector2[200, 200], colour: Colour::WHITE)

    # Medium text
    Font.default.draw(outcome, size: 38, position: Vector2[310, 250], colour: Colour::WHITE)

    # Bottom text
    Font.default.draw('Press R to restart the game', size: 38, position: Vector2[130, 550], colour: Colour::WHITE)
  end
end
