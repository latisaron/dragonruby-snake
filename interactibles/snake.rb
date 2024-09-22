class Snake
  attr_accessor :options

  def initialize
    @options = default_snake
  end

  def default_snake
    [
      {
        x: 100, y: 100,
        w: 20, h: 20,
        path: 'sprites/square/black.png',
      },
    ]
  end

  def self.generate_snake(args)
    args.state.snake = self.new
  end

  def head
    @options[0]
  end

  def add_part(part)
    @options << part
  end

  def tail
    @options[-1]
  end

  def collide_with_wall
    args.state.generic_game_state.game_state = :game_over
  end

  def collide_with_apple(args, tmp_node)
    args.state.points += 1
    args.state.snake.add_part(tmp_node)
    args.state.environment_builder.build_apple
  end

  def collide_with_self
    args.state.generic_game_state.game_state = :game_over
  end

  private

  def move_player(direction)
    case direction
    when 0
      generic_movement(:y, 1)
    when 1
      generic_movement(:x, 1)
    when 2
      generic_movement(:y, -1)
    when 3
      generic_movement(:x, -1)
    else
      nil
    end
  end
  
  def generic_movement(ax, multiplier)
    maxsize = @options.size
    @options.reverse.each_with_index do |piece, index|
      if index == maxsize - 1
        piece[ax] += 20 * multiplier
      else
        piece[:y] = @options[maxsize - index - 2][:y]
        piece[:x] = @options[maxsize - index - 2][:x]
      end
    end
  end
  
end