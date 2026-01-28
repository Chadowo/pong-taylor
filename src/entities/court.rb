# Background court
class Court
  def initialize
    @texture = Texture2D.new('./assets/court.png')
    @rectangle = Rectangle.new(x: 0, y: 0, width: 800, height: 600)
  end

  def draw
    @texture.draw(destination: @rectangle)
  end
end
