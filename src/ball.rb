
require 'collision'

class Ball
  attr_reader :x, :y, :w, :h
  include Collision

  def initialize
    @speed = 300
    @xvel = -@speed
    @yvel = 0
    @texture = Texture2D.load('./assets/ball.png')
    @rectangle = Rectangle.new(400 - @texture.width / 2, 300 - @texture.height / 2, @texture.width, @texture.height)

    @x, @y = @rectangle.x, @rectangle.y
    @w, @h = @texture.width, @texture.height
  end

  def update(dt)
    @rectangle.x = @x
    @rectangle.y = @y

    @x += @xvel * dt
    @y += @yvel * dt
    
    collisions
  end

  def collisions
    if collide_border?(:up)
      @y = 0
      @yvel = -@yvel
    elsif collide_border?(:down)
      @y = Game::WINDOW_HEIGHT - @h
      @yvel = -@yvel
    elsif collide_border?(:left)
      Game.rival.point
      reset
    elsif collide_border?(:right)
      Game.player.point
      reset
    end

    collide_player
    collide_ai
  end

  def collide_player
    if collide?(Game.player)
      @xvel = @speed

      middle_ball = @y + @h / 2
      middle_player = Game.player.y + Game.player.h / 2
      collision_position = middle_ball - middle_player
      @yvel = collision_position * 6
    end
  end

  def collide_ai
    if collide?(Game.rival)
      @xvel = -@speed

      middle_ball = @y + @h / 2
      middle_rival = Game.rival.y + Game.rival.h / 2
      collision_position = middle_ball - middle_rival
      @yvel = collision_position * 6
    end
  end

  def reset
   # We give the ball to the paddle that lost a point
   @xvel = collide_border?(:left) ? -@speed : @speed
   @yvel = 0
   @x = 400 - @texture.width / 2
   @y = 300 - @texture.height / 2
  end

  def draw
    @texture.draw(destination: @rectangle)
  end
end
