
require 'collision'

class AI
  attr_reader :x, :y, :w, :h, :score

  def initialize
    @texture = Texture2D.load('./assets/paddle.png')
    @rectangle = Rectangle.new(Game::WINDOW_WIDTH - (25 + @texture.width), 
                               300 - (@texture.height / 2),
                               @texture.width,
                               @texture.height)
    @x, @y = @rectangle.x, @rectangle.y
    @w, @h = @texture.width, @texture.height

    @yvel = 0
    @speed = 500

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
    target_ball
  end

  def move(dt)
    @y += @yvel * dt
  end

  # TODO: I feel like this can be done better
  def target_ball
    if Game.ball.y + Game.ball.h < @y 
      @yvel = -@speed
    elsif Game.ball.y > @y + @h
      @yvel = @speed
    else
      @yvel = 0
    end
  end

  def draw
    @texture.draw(destination: @rectangle)
    draw_score
  end

  def draw_score
    draw_text(@score.to_s, 470, 20, 48, WHITE)
  end
end
