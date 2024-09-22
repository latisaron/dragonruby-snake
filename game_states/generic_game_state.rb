require 'app/game_states/menu.rb'
require 'app/game_states/game_play.rb'
require 'app/game_states/game_over.rb'
require 'app/game_states/pause.rb'

class GenericGameState
  attr_accessor :game_state
  
  def initialize(args, game_state)
    @game_state = game_state
    @_args = args
  end

  def state_changes
    case @game_state
    when :menu
      Menu.state_changes(@_args)
    when :game_over
      GameOver.state_changes(@_args)
    when :game_play
      GamePlay.state_changes(@_args)
    when :pause
      Pause.state_changes(@_args)
    else
      nil
    end
  end

  def render
    case @game_state
    when :menu
      Menu.render(@_args)
    when :game_over
      GameOver.render(@_args)
    when :game_play
      GamePlay.render(@_args)
    when :pause
      Pause.render(@_args)
    else
      nil
    end
  end

  def handle_user_inputs
    case @game_state
    when :menu
      Menu.handle_user_inputs(@_args)
    when :game_over
      GameOver.handle_user_inputs(@_args)
    when :game_play
      GamePlay.handle_user_inputs(@_args)
    when :pause
      Pause.handle_user_inputs(@_args)
    else
      nil
    end
  end
end