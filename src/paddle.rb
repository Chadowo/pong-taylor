
require 'collision'

class Paddle
  attr_reader :x, :y, :w, :h, :score

  include Collision

  def initialize
    @texture = Texture2D.load('./assets/paddle.png')
    @rectangle = Rectangle.new(25, 300 - @texture.height / 2, @texture.width, @texture.height)
    @x, @y = @rectangle.x, @rectangle.y
    @w, @h = @texture.width, @texture.height
    @score = 0
  end

  def reset
    @y = 300 - @texture.height / 2
    @score = 0
  end

  def point
    @score += 1 unless @score == 10
  end

  def update(dt)
    @rectangle.x = @x
    @rectangle.y = @y

    move(dt)
  end

  def move(dt)
    if key_down?(KEY_S) && !collide_border?(:down)
      @y += 400 * dt
    elsif key_down?(KEY_W) && !collide_border?(:up)
      @y -= 400 * dt
    end
  end

  def draw
    @texture.draw(destination: @rectangle)
    draw_score
  end

  def draw_score
    draw_text(@score.to_s, 300, 20, 48, WHITE)
  end
end
