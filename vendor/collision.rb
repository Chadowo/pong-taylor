
module Collision

  # AABB Collision detection.
  # box1 defaults to calling object.
  def collide?(box1 = self, box2)
    if (box1.x < box2.x + box2.w &&
        box1.x + box1.w > box2.x &&
        box1.y < box2.y + box2.h &&
        box1.y + box1.h > box2.y)
      true
    end
  end

  # Collision with a border of the game screen.
  # box defaults to calling object.
  #
  # possible options are :up, :down, :left, :right
  def collide_border?(border, box = self)
    case border
    when :up
      true if box.y <= 0
    when :down
      true if box.y + box.h >= Game::WINDOW_HEIGHT
    when :left
      true if box.x <= 0
    when :right
      true if box.x + box.w >= Game::WINDOW_WIDTH
    else 
      raise(ArgumentError, "Border #{border} isn't a valid option")
    end
  end
end
