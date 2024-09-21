
def tick args
  # DIRECTION
  # 0 UP
  # 1 RIGHT
  # 2 DOWN
  # 3 LEFT
  args.outputs.background_color = [169, 224, 0, 255]

  args.state._movement_ticks ||= 1
  args.state.points ||= 0

  args.state.snake_pieces ||= [
    {
      x: 100, y: 100,
      w: 20, h: 20,
      path: 'sprites/square/black.png',
    },
  ]

  args.state.depict ||= :menu

  args.state.direction ||= 0
  args.state.apple_existence ||= false

  args.state._bottom_wall ||= {
    x: 20,
    y: 18,
    w: 1240,
    h: 2,
    r: 0,
    g: 0,
    b: 0,
    a: 254,
  }

  args.state._left_wall ||= {
    x: 18,
    y: 20,
    w: 2,
    h: 680,
    r: 0,
    g: 0,
    b: 0,
    a: 254,
  }

  args.state._up_wall = {
    x: 20,
    y: 700,
    w: 1240,
    h: 2,
    r: 0,
    g: 0,
    b: 0,
    a: 254,
  }

  args.state._right_wall = {
    x: 1260,
    y: 20,
    w: 2,
    h: 680,
    r: 0,
    g: 0,
    b: 0,
    a: 254,
  }

  args.state._wall_colision ||= false

  if args.inputs.keyboard.key_down.escape && args.state.depict == :gameplay
    args.state.depict = :pause
  end

  if args.state.depict == :gameplay
    if !args.state._wall_colision
      if args.inputs.keyboard.key_down.up
        args.state.direction = 0 if args.state.direction != 2
      elsif args.inputs.keyboard.key_down.down
        args.state.direction = 2 if args.state.direction != 0
      end

      if args.inputs.keyboard.key_down.left
        args.state.direction = 3 if args.state.direction != 1
      elsif args.inputs.keyboard.key_down.right
        args.state.direction = 1 if args.state.direction != 3
      end

      tmp_node = {
        x: args.state.snake_pieces[-1][:x],
        y: args.state.snake_pieces[-1][:y],
        w: args.state.snake_pieces[-1][:w],
        h: args.state.snake_pieces[-1][:h],
        path: args.state.snake_pieces[-1][:path]
      }

      inversespeed = [7 - (args.state.points / 10).to_i, 3].max
      if args.state._movement_ticks % inversespeed == 0
        move_player(args.state.snake_pieces, args.state.direction)
      end

      if !args.state.apple_existence
        args.state.apple = {
          **generate_random_location(args.state.snake_pieces),
          w: 20, h: 20,
          path: 'sprites/circle/black.png',
        }
        args.state.apple_existence = true
      else
        if args.state.apple.intersect_rect?(args.state.snake_pieces[0])
          args.state.points += 1
          args.state.snake_pieces << tmp_node
          args.state.apple = args.state.apple = {
            **generate_random_location(args.state.snake_pieces),
            w: 20, h: 20,
            path: 'sprites/circle/black.png',
          }
        end
      end

      args.state._movement_ticks = args.state._movement_ticks % 60 + 1

      args.state._wall_colision = args.state.snake_pieces[0].intersect_rect?(args.state._bottom_wall) ||
        args.state.snake_pieces[0].intersect_rect?(args.state._left_wall) ||
        args.state.snake_pieces[0].intersect_rect?(args.state._right_wall) ||
        args.state.snake_pieces[0].intersect_rect?(args.state._up_wall) ||
        ouroboros(args.state.snake_pieces)
    end
  end

  if args.state.depict == :menu
    args.outputs.labels << {
        x: 640, y: 360,
        text: 'Snake Game',
        size_enum: 10,
        alignment_enum: 1,
        r: 5, g: 0, b: 0,
      }

      args.outputs.labels << {
        x: 640, y: 300,
        text: "Press 'S' to Start",
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

      if args.inputs.keyboard.key_down.s
        args.state.depict = :gameplay
      elsif args.inputs.keyboard.key_down.q
        $gtk.request_quit
      end
  elsif args.state.depict == :pause
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

      if args.inputs.keyboard.key_down.c
        args.state.depict = :gameplay
      elsif args.inputs.keyboard.key_down.q
        $gtk.request_quit
      end
  else
    if args.state._wall_colision
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

      if args.inputs.keyboard.key_down.r
        args.state._wall_colision = false
        args.state.points = 0
        args.state.snake_pieces = [{x: 100, y: 200, h: 20, w: 20, path: 'sprites/square/black.png'}]
        args.state.direction = 0
      elsif args.inputs.keyboard.key_down.q
        $gtk.request_quit
      end

    else
      args.outputs.solids << args.state._bottom_wall
      args.outputs.solids << args.state._left_wall
      args.outputs.solids << args.state._right_wall
      args.outputs.solids << args.state._up_wall
      
      args.outputs.labels << {
        x: 40, y: 721,
        text: "#{args.state.points} points",
        size_enum: 0,
        alignment_enum: 0,
        r: 0, g: 0, b: 0
      }

      args.state.snake_pieces.each do |piece|
        args.outputs.sprites << piece
      end

      args.outputs.sprites << args.state.apple if !args.state.apple.nil? 
    end
  end
end

def move_player(snake_pieces, direction)
  case direction
  when 0
    
    generic_movement(snake_pieces, :y, 1)
  when 1
    generic_movement(snake_pieces, :x, 1)
  when 2
    generic_movement(snake_pieces, :y, -1)
  when 3
    generic_movement(snake_pieces, :x, -1)
  else
    nil
  end
end

def generic_movement(snake_pieces, ax, multiplier)
  maxsize = snake_pieces.size
  snake_pieces.reverse.each_with_index do |piece, index|
    if index == maxsize - 1
      piece[ax] += 20 * multiplier
    else
      piece[:y] = snake_pieces[maxsize - index - 2][:y]
      piece[:x] = snake_pieces[maxsize - index - 2][:x]
    end
  end
end


def generate_restricted_squares(snake_pieces)
  snake_pieces.map do |block|
    {
      x1: block[:x] - 10,
      x2: block[:x] + 10,
      y1: block[:y] - 10,
      y2: block[:y] + 10,
    }
  end
end

def inside_restricted_area?(x, y, restricted_squares)
  restricted_squares.any? do |square|
    x >= square[:x1] && x <= square[:x2] &&
    y >= square[:y1] && y <= square[:y2]
  end
end

def generate_random_location(snake_pieces)
  restricted_squares = generate_restricted_squares(snake_pieces)
  loop do
    x = (1 + rand(62)) * 20
    y = (1 + rand(34)) * 20

    return {x: x, y: y} unless inside_restricted_area?(x, y, restricted_squares)
  end
end

def ouroboros(snake_pieces)
  snake_pieces[1..-1].any? do |piece|
    piece.intersect_rect?(snake_pieces[0])
  end
end
