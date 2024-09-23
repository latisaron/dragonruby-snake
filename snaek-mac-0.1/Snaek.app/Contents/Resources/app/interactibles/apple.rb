class Apple
  attr_accessor :options

  def initialize(args)
    @options = {
      **generate_random_location(args.state.snake.options),
      w: 20, h: 20,
      path: 'sprites/circle/red.png',
    }
  end

  def self.generate_apple(args)
    args.state.apple = self.new(args)
  end

  private

  def inside_restricted_area?(x, y, restricted_squares)
    restricted_squares.any? do |square|
      x >= square[:x1] && x <= square[:x2] &&
      y >= square[:y1] && y <= square[:y2]
    end
  end
  
  def generate_random_location(snake_pieces)
    restricted_squares = generate_restricted_squares(snake_pieces)
    loop do
      x = (1 + rand(62)) * 20
      y = (1 + rand(34)) * 20
  
      return {x: x, y: y} unless inside_restricted_area?(x, y, restricted_squares)
    end
  end

  def generate_restricted_squares(snake_pieces)
    snake_pieces.map do |block|
      {
        x1: block[:x] - 10,
        x2: block[:x] + 10,
        y1: block[:y] - 10,
        y2: block[:y] + 10,
      }
    end
  end
  
end