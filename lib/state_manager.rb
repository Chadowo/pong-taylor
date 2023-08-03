
# Finite State Machine (FSM) implementation
module StateManager
  @current_state = nil

  def set_state(other_state)
    @current_state = other_state if other_state.is_a? State
    @current_state.on_enter
  end

  def update(dt)
    @current_state.update(dt)
  end

  def draw
    @current_state.draw
  end

  # TODO: Superstate and Substate classes

  # Basic state skeleton
  class State
  	# Called when entering the state
    def on_enter; end

    def initialize; end

    def update(dt); end

    def draw; end
  end

  module_function :set_state, :update, :draw
end
