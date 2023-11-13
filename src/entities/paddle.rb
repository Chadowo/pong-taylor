require 'collision'

# Controllable paddle
class Paddle
  attr_reader :x, :y, :w, :h, :score

  include Collision

  MAXIMUM_SCORE = 10
  SPEED = 400

  def initialize
    @texture = Texture2D.load('./assets/paddle.png')
    @rectangle = Rectangle.new(25,
                               300 - @texture.height / 2,
                               @texture.width,
                               @texture.height)

    @x = @rectangle.x
    @y = @rectangle.y
    @w = @texture.width
    @h = @texture.height

    @score = 0
  end

  def update(dt)
    # Rectangle coords are used for rendering
    @rectangle.x = @x
    @rectangle.y = @y

    move(dt)
  end

  def move(dt)
    if key_down?(KEY_S) && !collide_border?(:down)
      @y += SPEED * dt
    elsif key_down?(KEY_W) && !collide_border?(:up)
      @y -= SPEED * dt
    end
  end

  def reset
    @y = 300 - @texture.height / 2
    @score = 0
  end

  def increment_score
    @score += 1 unless @score == MAXIMUM_SCORE
  end

  def draw
    @texture.draw(destination: @rectangle)
    draw_text(@score.to_s, 300, 20, 48, WHITE)
  end
end
