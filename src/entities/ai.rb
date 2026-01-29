require 'collision'

# Bare-bones AI for the game
class AI
  attr_reader :x, :y, :w, :h, :score

  SPEED = 500

  def initialize
    @texture = Texture2D.new('./assets/paddle.png')
    @rectangle = Rectangle.new(x: GamePong::WINDOW_WIDTH - (25 + @texture.width),
                               y: 300 - (@texture.height / 2),
                               width: @texture.width,
                               height: @texture.height)

    @x = @rectangle.x
    @y = @rectangle.y
    @w = @texture.width
    @h = @texture.height

    @yvel = 0
    @score = 0
  end

  def update(dt)
    # Rectangle coords are used for rendering
    @rectangle.x = @x
    @rectangle.y = @y

    move(dt)
  end

  def move(dt)
    @y += @yvel * dt
  end

  # Kinda wonky tracking, could use some upgrades
  def track_ball(ball)
    @yvel = if ball.y + ball.h < @y
              -SPEED
            elsif ball.y > @y + @h
              SPEED
            else
              0
            end
  end

  def reset
    @y = 300 - @texture.height / 2
    @score = 0
  end

  def increment_score
    @score += 1 unless @score == 10
  end

  def draw
    @texture.draw(destination: @rectangle)
    Font.default.draw(@score.to_s, size: 48, position: Vector2[470, 20], colour: Colour::WHITE)
  end
end
