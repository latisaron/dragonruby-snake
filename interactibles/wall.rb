class Wall
  def initialize(options, args)
    @options = options
    @_args = args
  end

  def render
    @_args.outputs.solids << @options
  end

  def collision_with(rect)
    @options.intersect_rect?(rect)
  end
end