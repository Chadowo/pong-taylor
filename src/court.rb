
class Court
  def initialize
    @texture = Texture2D.load('./assets/court.png')
    @rectangle = Rectangle.new(0, 0, 800, 600)
  end

  def draw
    @texture.draw(destination: @rectangle)
  end
end
