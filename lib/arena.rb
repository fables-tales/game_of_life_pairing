class Arena
  def initialize(world)
    @world = world
  end

  def step
    @new_world = world.dup.map! { |row| row.dup }
    world.each_with_index do |row_array, row_position|
      row_array.each_with_index do |cell, column_position|
        an = alive_neighbors(column_position, row_position)
        if cell && an  < 2
          kill(column_position, row_position)
        elsif cell && an > 3
          kill(column_position, row_position)
        elsif cell && [2,3].include?(an)
          #!?!?!?!?!
        elsif !cell && an == 3
          bring_to_life(column_position, row_position)
        end
      end
    end

    @world = new_world

    world
  end

  def alive_neighbors(col, row)
    count = 0
    (-1..1).each do |y_offset|
      (-1..1).each do |x_offset|
        if !(y_offset == 0 && x_offset == 0)
          if (col + x_offset >= 0) && (row + y_offset >= 0)
            if world[row+y_offset] && world[row+y_offset][col+x_offset]
              count += 1
            end
          end
        end
      end
    end

    count
  end

  protected

  attr_reader :world, :new_world

  private

  def kill(col, row)
    new_world[row][col] = false
  end

  def bring_to_life(col, row)
    new_world[row][col] = true
  end
end
