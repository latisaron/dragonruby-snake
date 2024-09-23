require 'app/game_states/generic_game_state.rb'
require 'app/collision_manager.rb'
require 'app/environment_builder.rb'
require 'app/miscellaneous_manager.rb'

def tick args
  # DIRECTION
  # 0 UP
  # 1 RIGHT
  # 2 DOWN
  # 3 LEFT
  
  # this is the generic state, starting in the menu
  args.state.generic_game_state ||= GenericGameState.new(args, :menu)

  # this is the collision manager which every single interactible should update and inform of the state
  args.state.collision_manager ||= CollisionManager.new(args)

  # self explanatory
  args.outputs.background_color = [169, 224, 0, 255]

  # should probably migrate this to a builder
  args.state.environment_builder ||= EnvironmentBuilder.new(args)
  args.state.environment_builder.build_environment
  args.state.environment_builder.build_snake

  # initialize miscellaneous stuff
  args.state.miscellaneous_manager ||= MiscellaneousManager.new(args)
  args.state.miscellaneous_manager.init_miscs if args.state.direction.nil?

  # handle the state changes through sprites interaction
  args.state.generic_game_state.state_changes
  # render the state changes
  args.state.generic_game_state.render
  # handle user inputs for all possible menus
  args.state.generic_game_state.handle_user_inputs
end
