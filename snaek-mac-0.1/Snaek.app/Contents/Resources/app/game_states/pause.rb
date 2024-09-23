class Pause
  class << self
    def state_changes(_); nil; end

    def render(args)
      args.outputs.labels << {
        x: 640, y: 360,
        text: 'Snake Game',
        size_enum: 10,
        alignment_enum: 1,
        r: 5, g: 0, b: 5,
      }

      args.outputs.labels << {
        x: 640, y: 300,
        text: "Press 'C' to Continue",
        size_enum: 6,
        alignment_enum: 1,
        r: 5, g: 0, b: 5
      }
    
      args.outputs.labels << {
        x: 640, y: 250,
        text: "Press 'Q' to Quit",
        size_enum: 6,
        alignment_enum: 1,
        r: 5, g: 0, b: 5
      }
    end

    def handle_user_inputs(args)
      if args.inputs.keyboard.key_down.c
        args.state.generic_game_state.game_state = :game_play
      elsif args.inputs.keyboard.key_down.q
        $gtk.request_quit
      end
    end
  end
end