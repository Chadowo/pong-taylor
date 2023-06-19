
class Court
  def initialize
    @rectangle = Rectangle.new(0, 0, 800, 600)
    @texture = Texture2D.load('./assets/court.png')
  end
  
  def draw
    @texture.draw(destination: @rectangle)
  end
end
