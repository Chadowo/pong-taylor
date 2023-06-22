require 'collision'

# Collidable ball
class Ball
  attr_reader :x, :y, :w, :h

  include Collision

  SPEED = 300

  def initialize
    @texture = Texture2D.load('./assets/ball.png')
    @rectangle = Rectangle.new(400 - @texture.width / 2,
                               300 - @texture.height / 2,
                               @texture.width,
                               @texture.height)

    @x = @rectangle.x
    @y = @rectangle.y
    @w = @texture.width
    @h = @texture.height

    @xvel = -SPEED
    @yvel = 0
  end

  # Sets the two players to play with
  def set_sides(left_paddle, right_paddle)
    @left_paddle = left_paddle
    @right_paddle = right_paddle
  end

  def update(dt)
    @rectangle.x = @x
    @rectangle.y = @y

    @x += @xvel * dt
    @y += @yvel * dt

    # Prevent stucking in the borders
    if @y.negative?
      @y = 0
    elsif @y + @h > Game::WINDOW_HEIGHT
      @y = Game::WINDOW_HEIGHT - @h
    end

    collisions
  end

  def collisions
    collide_borders
    collide_player
    collide_ai
  end

  def collide_borders
    if collide_border?(:up) || collide_border?(:down)
      @yvel = -@yvel
    elsif collide_border?(:left)
      @right_paddle.increment_score
      reset
    elsif collide_border?(:right)
      @left_paddle.increment_score
      reset
    end
  end

  def collide_player
    return false unless collide?(@left_paddle)

    # Depending on the distance between the two
    # middle points we modify the y velocity.
    # This gives us the effect of having more
    # velocity when colliding with the edges of
    # the paddle

    middle_ball = @y + @h / 2
    middle_player = @left_paddle.y + @left_paddle.h / 2
    collision_position = middle_ball - middle_player

    @xvel = SPEED
    @yvel = collision_position * 6
  end

  def collide_ai
    return false unless collide?(@right_paddle)

    middle_ball = @y + @h / 2
    middle_rival = @right_paddle.y + @right_paddle.h / 2
    collision_position = middle_ball - middle_rival

    @xvel = -SPEED
    @yvel = collision_position * 6
  end

  # Reset the ball to its initial position, serving
  # to the player that lost a point
  def reset
    @x = 400 - @texture.width / 2
    @y = 300 - @texture.height / 2

    # We give the ball to the side that lost a point
    @xvel = collide_border?(:left) ? -SPEED : SPEED
    @yvel = 0
  end

  def draw
    @texture.draw(destination: @rectangle)
  end
end
