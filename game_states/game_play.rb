class GamePlay
  class << self
    def state_changes(args)
      tmp_node = {
        x: args.state.snake.tail[:x],
        y: args.state.snake.tail[:y],
        w: args.state.snake.tail[:w],
        h: args.state.snake.tail[:h],
        path: args.state.snake.tail[:path]
      }

      inversespeed = [7 - (args.state.points / 10).to_i, 3].max
      if args.state._movement_ticks % inversespeed == 0
        args.state.snake.move_player(args.state.direction)
        args.state.moved_after_direction_change = true
      end

      if args.state.apple.nil?
        args.state.environment_builder.build_apple
        args.state.apple_existence = true
      else
        if args.state.collision_manager.snake_apple_collision?
          args.state.snake.collide_with_apple(args, tmp_node)
        end
      end

      args.state._movement_ticks = args.state._movement_ticks % 60 + 1

      args.state.snake.collide_with_self(args) if args.state.collision_manager.ouroboros?
      args.state.snake.collide_with_wall(args) if args.state.collision_manager.snake_wall_collision?
    end

    def render(args)
      args.state.walls.each(&:render)
      
      args.outputs.labels << {
        x: 40, y: 721,
        text: "#{args.state.points} points",
        size_enum: 0,
        alignment_enum: 0,
        r: 0, g: 0, b: 0
      }

      args.state.snake.options.each do |piece|
        args.outputs.sprites << piece
      end

      args.outputs.sprites << args.state.apple.options if !args.state.apple.nil? 
    end

    def handle_user_inputs(args)
      if args.inputs.keyboard.key_down.escape && args.state.generic_game_state.game_state == :game_play
        args.state.generic_game_state.game_state = :pause
      end

      if args.state.moved_after_direction_change 
        if args.inputs.keyboard.key_down.up
          args.state.direction = 0 if args.state.direction != 2
          args.state.moved_after_direction_change = false
        elsif args.inputs.keyboard.key_down.down
          args.state.direction = 2 if args.state.direction != 0
          args.state.moved_after_direction_change = false
        end

        if args.inputs.keyboard.key_down.left
          args.state.direction = 3 if args.state.direction != 1
          args.state.moved_after_direction_change = false
        elsif args.inputs.keyboard.key_down.right
          args.state.direction = 1 if args.state.direction != 3
          args.state.moved_after_direction_change = false
        end
      end
    end
  end
end