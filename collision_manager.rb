class CollisionManager
  def initialize(args)
    @_args = args
  end

  def check_all_collisions
    if snake_apple_collision

    elsif ouroboros

    elsif snake_wall_collision

    end
  end

  # private

  def snake_apple_collision?
    @_args.state.apple.options.intersect_rect?(@_args.state.snake.head)
  end

  def ouroboros?
    @_args.state.snake.options[1..-1].any? do |piece|
      piece.intersect_rect?(@_args.state.snake.options[0])
    end
  end

  def snake_wall_collision?
    @_args.state.walls.inject(false) {|res, x| res || x.collision_with(@_args.state.snake.head)}
  end
end