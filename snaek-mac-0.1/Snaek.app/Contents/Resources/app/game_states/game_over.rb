class GameOver
  class << self
    def state_changes(_); nil; end

    def render(args)
      args.outputs.labels << {
        x: 640, y: 360,
        text: 'Game Over',
        size_enum: 10,
        alignment_enum: 1,
        r: 5, g: 0, b: 0,
      }

      args.outputs.labels << {
        x: 640, y: 300,
        text: "Press 'R' to Restart",
        size_enum: 6,
        alignment_enum: 1,
        r: 0, g: 0, b: 0
      }
    
      args.outputs.labels << {
        x: 640, y: 250,
        text: "Press 'Q' to Quit",
        size_enum: 6,
        alignment_enum: 1,
        r: 5, g: 0, b: 0
      }
    end

    def handle_user_inputs(args)
      # puts "args is #{args}"
      if args.inputs.keyboard.key_down.r
        # puts "are we ever here?"
        args.state.environment_builder.build_snake(true)
        args.state.miscellaneous_manager.init_miscs
        args.state.generic_game_state.game_state = :game_play
      elsif args.inputs.keyboard.key_down.q
        $gtk.request_quit
      end
    end
  end
end