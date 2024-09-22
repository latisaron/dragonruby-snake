class MiscellaneousManager
  def initialize(args)
    @_args = args
  end

  def init_miscs
    @_args.state._movement_ticks = 1
    @_args.state.points = 0
    @_args.state.direction = 0
  end
end