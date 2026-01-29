# Background court
class Court
  def initialize
    @texture = Texture2D.new('./assets/court.png')
    @rectangle = Rectangle.new(x: 0, y: 0, width: GamePong::WINDOW_WIDTH, height: GamePong::WINDOW_HEIGHT)
  end

  def draw
    @texture.draw(destination: @rectangle)
  end
end
