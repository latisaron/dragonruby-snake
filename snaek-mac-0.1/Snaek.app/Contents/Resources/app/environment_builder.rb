require 'app/interactibles/wall.rb'
require 'app/interactibles/apple.rb'
require 'app/interactibles/snake.rb'

class EnvironmentBuilder
  def initialize(args)
    @_args = args
  end

  def build_environment
    build_walls
  end

  def build_apple
    Apple.generate_apple(@_args)
  end

  def build_snake(rebuild = false)
    if rebuild
      Snake.generate_snake(@_args)
    else
      @_snake ||= Snake.generate_snake(@_args)
    end
  end

  private

  def build_walls
    @_args.state.walls ||= [
    Wall.new(
      {
        x: 20,
        y: 18,
        w: 1240,
        h: 2,
        r: 0,
        g: 0,
        b: 0,
        a: 254,
      },
      @_args,  
    ),
    Wall.new(
      {
        x: 18,
        y: 20,
        w: 2,
        h: 680,
        r: 0,
        g: 0,
        b: 0,
        a: 254,
      },
      @_args,
    ),
    Wall.new(
      {
        x: 20,
        y: 700,
        w: 1240,
        h: 2,
        r: 0,
        g: 0,
        b: 0,
        a: 254,
      },
      @_args,
    ),
    Wall.new(
      {
        x: 1260,
        y: 20,
        w: 2,
        h: 680,
        r: 0,
        g: 0,
        b: 0,
        a: 254,
      },
      @_args
    ),
  ]
  end
end