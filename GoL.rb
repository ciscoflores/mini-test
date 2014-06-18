class Cell
	# By default a cell is alive when it's born
	def initialize(status = :alive)
		@status = status
	end

	def life_status
		@status
	end
end

class World
	# Defines the size of the grid, which is square
	def initialize(size)
		@size = size
		@colony = Array.new(size) { Array.new(size, Cell.new(:dead)) }
	end

	# Let define a specific position of the grid, with a cell in a specific status
	def set_location(row, column, state)
		@colony[row][column] = Cell.new(state)	
	end

	# It's the "tick" moment, check if which cells gonna live or die and generate the next grid
	def doomsday
		@temp_colony = Array.new(@size) { Array.new(@size,0) }

		@colony.each_with_index do |row, y|
			row.each_with_index do |column, x|
				@sum = check_neighborhood(y,x)
				@temp_colony[y][x] = @colony[y][x].life_status == :alive ? Cell.new(@sum.between?(2,3) ? :alive : :dead) : Cell.new(@sum == 3 ? :alive : :dead)
			end			
		end
		@colony = @temp_colony	
	end

	# Determines the number of neighboors for a specific cell on the grid
	def check_neighborhood(y,x)
		[[-1,0], [1,0],
		 [-1,1], [0,1], [1,1],
		 [-1,-1],[0,1],[1,-1]].inject(0) do |sum, pos|
		 sum + 
		 ( @colony[(y + pos[0]) % @size][(x + pos[1]) % @size].life_status == :alive ? 1 : 0 )
		end
	end

	def print_world
		@colony.each_with_index do |row|
			row.each_with_index do |cell|
			 	print cell.life_status.to_s + ' ' 
			end
			puts ''
		end
		puts ''	
	end
end

@game = World.new(4)
@game.set_location(0,3,:alive)
@game.set_location(1,2,:alive)
@game.set_location(1,3,:alive)
@game.print_world
@game.doomsday
@game.print_world
